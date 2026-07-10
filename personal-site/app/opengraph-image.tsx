import { readFile } from "fs/promises";
import { join } from "path";
import { ImageResponse } from "next/og";

export const alt = "David Skadron — Builder · Founder · Human";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

async function loadGoogleFont(family: string, weight: number, text: string) {
  const url = `https://fonts.googleapis.com/css2?family=${family}:wght@${weight}&text=${encodeURIComponent(text)}`;
  const css = await (await fetch(url)).text();
  const match = css.match(/src: url\((.+?)\) format\('(opentype|truetype|woff2?)'\)/);
  if (!match) {
    throw new Error(`Failed to load font: ${family} ${weight}`);
  }
  return fetch(match[1]).then((res) => res.arrayBuffer());
}

export default async function Image() {
  const portrait = await readFile(
    join(process.cwd(), "public/images/hero/portrait.jpg"),
  );
  const portraitSrc = `data:image/jpeg;base64,${portrait.toString("base64")}`;

  const eyebrow = "Builder · Founder · Human";
  const name = "David Skadron";
  const thesis = "I see a problem and find the solution.";
  const fontText = `${eyebrow}${name}${thesis}`;

  const [displayFont, bodyFont] = await Promise.all([
    loadGoogleFont("Fraunces", 500, fontText),
    loadGoogleFont("Outfit", 500, fontText),
  ]);

  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          position: "relative",
          overflow: "hidden",
          background: "#07090d",
        }}
      >
        {/* Portrait — cropped like the homepage hero */}
        <img
          src={portraitSrc}
          alt=""
          width={1200}
          height={630}
          style={{
            position: "absolute",
            inset: 0,
            width: "100%",
            height: "100%",
            objectFit: "cover",
            objectPosition: "72% 58%",
          }}
        />

        {/* Homepage-style shading — strong enough for OG preview contrast */}
        <div
          style={{
            position: "absolute",
            inset: 0,
            background:
              "linear-gradient(90deg, #07090d 0%, #07090d 28%, rgba(7,9,13,0.82) 48%, rgba(7,9,13,0.35) 70%, rgba(7,9,13,0.15) 100%)",
          }}
        />
        <div
          style={{
            position: "absolute",
            inset: 0,
            background:
              "linear-gradient(0deg, #07090d 0%, rgba(7,9,13,0.75) 35%, rgba(7,9,13,0.2) 65%, transparent 100%)",
          }}
        />
        <div
          style={{
            position: "absolute",
            inset: 0,
            background:
              "radial-gradient(ellipse 65% 50% at 15% 0%, rgba(61,139,253,0.14), transparent 55%)",
          }}
        />

        {/* Copy — matches hero hierarchy */}
        <div
          style={{
            position: "relative",
            display: "flex",
            flexDirection: "column",
            justifyContent: "flex-end",
            padding: "64px 72px",
            width: "100%",
            height: "100%",
          }}
        >
          <div
            style={{
              display: "flex",
              fontFamily: "Outfit",
              fontSize: 22,
              letterSpacing: "0.22em",
              textTransform: "uppercase",
              color: "#7eb6ff",
              fontWeight: 500,
              marginBottom: 22,
            }}
          >
            {eyebrow}
          </div>
          <div
            style={{
              display: "flex",
              fontFamily: "Fraunces",
              fontSize: 92,
              lineHeight: 0.95,
              letterSpacing: "-0.03em",
              color: "#eef2f7",
              fontWeight: 500,
              maxWidth: 780,
            }}
          >
            {name}
          </div>
          <div
            style={{
              display: "flex",
              fontFamily: "Outfit",
              fontSize: 28,
              lineHeight: 1.35,
              color: "#c5cedb",
              fontWeight: 500,
              marginTop: 28,
              maxWidth: 640,
            }}
          >
            {thesis}
          </div>
        </div>
      </div>
    ),
    {
      ...size,
      fonts: [
        { name: "Fraunces", data: displayFont, style: "normal", weight: 500 },
        { name: "Outfit", data: bodyFont, style: "normal", weight: 500 },
      ],
    },
  );
}
