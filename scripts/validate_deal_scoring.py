#!/usr/bin/env python3
"""Mirrors DealScoringEngine for CI environments without Xcode."""

from __future__ import annotations

MSRP = {
    "Model Y": 44990,
    "Model 3": 42490,
    "Model S": 74990,
    "Model X": 79990,
    "Cybertruck": 79990,
}

SAMPLES = [
    {"id": "y-great-1", "model": "Model Y", "year": 2023, "price": 32900, "mileage": 18400, "accidents": 0, "owners": 1, "repairs": [], "hw": "HW3", "ap": "fsd"},
    {"id": "y-hw4-great", "model": "Model Y", "year": 2024, "price": 36500, "mileage": 9200, "accidents": 0, "owners": 1, "repairs": [], "hw": "HW4", "ap": "autopilot"},
    {"id": "x-bad-1", "model": "Model X", "year": 2022, "price": 72000, "mileage": 55000, "accidents": 2, "owners": 3, "repairs": ["moderate", "structural"], "hw": "HW3", "ap": "autopilot"},
    {"id": "y-bad-miles", "model": "Model Y", "year": 2020, "price": 29500, "mileage": 112000, "accidents": 1, "owners": 3, "repairs": ["moderate"], "hw": "HW3", "ap": "autopilot"},
]

CURRENT_YEAR = 2026
REPAIR_COST = {"minor": 400, "moderate": 1200, "major": 3500, "structural": 8000}
REPAIR_SCORE = {"minor": 5, "moderate": 12, "major": 25, "structural": 45}


def expected_miles(year: int) -> float:
    age = max(0.5, CURRENT_YEAR - year)
    return age * 12000


def fair_market(s: dict) -> float:
    age = max(0, CURRENT_YEAR - s["year"])
    value = MSRP[s["model"]]
    if age >= 1:
        value *= 0.82
        if age > 1:
            value *= 0.88 ** (age - 1)
    mile_delta = s["mileage"] - expected_miles(s["year"])
    value -= mile_delta * 0.12
    if s["ap"] == "fsd":
        value += 6000
    elif s["ap"] == "eap":
        value += 3000
    if s["hw"] in ("HW4", "AI4"):
        value += 2500
    value -= s["accidents"] * 2500
    for r in s["repairs"]:
        value -= REPAIR_COST[r]
    if s["owners"] > 2:
        value -= (s["owners"] - 2) * 800
    return max(8000, value)


def score_price(delta: float) -> float:
    if delta <= -20:
        return 100
    if delta >= 20:
        return 5
    return max(5, min(100, 55 - (delta * 2.25)))


def score_mileage(s: dict) -> float:
    expected = expected_miles(s["year"])
    ratio = s["mileage"] / expected
    if ratio <= 0.5:
        return 100
    if ratio >= 2.0:
        return 10
    return max(10, 100 - ((ratio - 0.5) * 60))


def score_condition(s: dict) -> float:
    score = 100.0
    score -= s["accidents"] * 22
    for r in s["repairs"]:
        score -= REPAIR_SCORE[r]
    if s["owners"] >= 3:
        score -= 10
    if s["owners"] >= 4:
        score -= 10
    return max(0, min(100, score))


def hardware_bonus(s: dict) -> float:
    if s["hw"] in ("HW4", "AI4"):
        return 8
    if s["hw"] == "HW3":
        return 3
    return 0


def grade(total: float, market_delta: float, condition: float) -> str:
    if condition < 40:
        return "Bad"
    if market_delta > 12 and total < 60:
        return "Bad"
    if total >= 82:
        return "Great" if market_delta <= -5 else "Good"
    if total >= 68:
        return "Good"
    if total >= 48:
        return "Fair"
    return "Bad"


def score(s: dict) -> dict:
    fmv = fair_market(s)
    delta = ((s["price"] - fmv) / fmv) * 100
    price = score_price(delta)
    miles = score_mileage(s)
    cond = score_condition(s)
    hw = hardware_bonus(s)
    total = min(100, max(0, price * 0.45 + miles * 0.25 + cond * 0.20 + hw))
    return {
        "id": s["id"],
        "score": round(total, 1),
        "grade": grade(total, delta, cond),
        "delta": round(delta, 1),
        "fmv": round(fmv),
        "mileage_score": round(miles, 1),
        "hw_bonus": hw,
    }


def main() -> None:
    results = [score(s) for s in SAMPLES]
    for r in results:
        print(f"{r['id']:14} {r['grade']:5} score={r['score']:5} delta={r['delta']:6}% fmv=${r['fmv']:,}")

    by_id = {r["id"]: r for r in results}
    assert by_id["y-great-1"]["grade"] in ("Great", "Good"), by_id["y-great-1"]
    assert by_id["x-bad-1"]["grade"] == "Bad", by_id["x-bad-1"]
    assert by_id["y-bad-miles"]["mileage_score"] < 50, by_id["y-bad-miles"]
    assert by_id["y-hw4-great"]["hw_bonus"] >= 8, by_id["y-hw4-great"]
    print("OK — deal scoring mirror passed")


if __name__ == "__main__":
    main()
