export function SkadAppLogo({ className = "" }: { className?: string }) {
  return (
    <div
      className={`flex items-center gap-4 rounded-2xl bg-[#5b2d8a] px-5 py-4 ${className}`}
      aria-label="Skadron Animal Hospital"
    >
      <svg
        viewBox="0 0 64 64"
        className="h-12 w-12 shrink-0 text-white"
        fill="none"
        aria-hidden
      >
        <path
          d="M14 42c2-10 8-18 16-22 4-2 8-2 11 1 3 3 4 8 3 13-1 4-1 8 1 12"
          stroke="currentColor"
          strokeWidth="2.4"
          strokeLinecap="round"
        />
        <path
          d="M18 28c6-8 14-12 22-10 5 1 9 5 10 10"
          stroke="currentColor"
          strokeWidth="2.4"
          strokeLinecap="round"
        />
        <circle cx="44" cy="30" r="2.2" fill="currentColor" />
        <path
          d="M12 46c8 2 18 3 28-1"
          stroke="currentColor"
          strokeWidth="2.4"
          strokeLinecap="round"
        />
      </svg>
      <div className="leading-tight text-white">
        <p className="font-display text-xl tracking-[0.08em]">SKADRON</p>
        <p className="mt-1 text-[0.65rem] tracking-[0.22em] text-white/80">
          ANIMAL HOSPITAL
        </p>
      </div>
    </div>
  );
}

function TotoAvatar() {
  return (
    <svg viewBox="0 0 120 120" className="h-28 w-28" aria-hidden>
      <circle cx="60" cy="60" r="58" fill="#6b3d1f" />
      <ellipse cx="38" cy="42" rx="16" ry="22" fill="#5a3218" />
      <ellipse cx="82" cy="42" rx="16" ry="22" fill="#5a3218" />
      <circle cx="60" cy="68" r="34" fill="#c48a55" />
      <circle cx="48" cy="64" r="5" fill="#1a120c" />
      <circle cx="72" cy="64" r="5" fill="#1a120c" />
      <ellipse cx="60" cy="76" rx="7" ry="5" fill="#1a120c" />
      <path d="M54 84c4 6 12 6 16 0" stroke="#e8b4c8" strokeWidth="4" strokeLinecap="round" />
      <ellipse cx="60" cy="92" rx="8" ry="5" fill="#e07a8a" />
    </svg>
  );
}

export function TotoListeningScreen() {
  return (
    <div className="phone-frame aspect-[9/19.5] bg-gradient-to-b from-[#2a1048] via-[#1a0b2e] to-[#0d0618] text-white">
      <div className="flex h-full flex-col px-5 pb-6 pt-8">
        <div className="flex items-center justify-between">
          <div className="flex h-10 w-10 items-center justify-center rounded-full bg-white/10 text-lg">
            ←
          </div>
          <div className="flex h-10 w-10 flex-col items-center justify-center gap-1 rounded-full bg-white/10">
            <span className="block h-0.5 w-4 rounded bg-white" />
            <span className="block h-0.5 w-4 rounded bg-white" />
            <span className="block h-0.5 w-4 rounded bg-white" />
          </div>
        </div>

        <div className="flex flex-1 flex-col items-center justify-center">
          <div className="relative flex h-44 w-44 items-center justify-center">
            <div className="absolute inset-0 animate-pulse rounded-full border border-[#b56bff]/30" />
            <div className="absolute inset-3 rounded-full border border-[#b56bff]/45 shadow-[0_0_40px_rgba(168,85,247,0.35)]" />
            <div className="absolute inset-6 rounded-full border border-[#c084fc]/70" />
            <div className="relative overflow-hidden rounded-full">
              <TotoAvatar />
            </div>
          </div>
          <p className="mt-6 text-lg font-semibold tracking-tight">Toto is listening</p>
        </div>

        <div className="mb-4 flex justify-center gap-4">
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-white/10">
            <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" aria-hidden>
              <rect x="9" y="3" width="6" height="11" rx="3" stroke="currentColor" strokeWidth="1.8" />
              <path d="M5 11a7 7 0 0 0 14 0" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" />
              <path d="M12 18v3" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" />
            </svg>
          </div>
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-white/10">
            <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" aria-hidden>
              <path d="M4 9v6h3l5 4V5L7 9H4z" stroke="currentColor" strokeWidth="1.8" strokeLinejoin="round" />
              <path d="M16 9.5a3.5 3.5 0 0 1 0 5" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" />
            </svg>
          </div>
        </div>

        <div className="flex items-center gap-2 rounded-full border border-[#a855f7]/40 bg-black/40 px-3 py-2 shadow-[0_0_24px_rgba(168,85,247,0.25)]">
          <p className="flex-1 truncate px-2 text-sm text-white/55">
            Ask about a patient or an…
          </p>
          <div className="flex items-center gap-1.5 rounded-full bg-[#9b4dff] px-3 py-2 text-sm font-medium">
            <span className="inline-block h-2.5 w-2.5 rounded-[2px] bg-white" />
            Stop
          </div>
        </div>
      </div>
    </div>
  );
}
