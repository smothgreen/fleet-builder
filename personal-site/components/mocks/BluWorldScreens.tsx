export function BluWorldSideQuestScreen() {
  return (
    <div className="phone-frame aspect-[9/19.5] bg-[#071018] text-white">
      <div className="relative flex h-full flex-col overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_40%,#1a3a55,transparent_55%),linear-gradient(180deg,#0b1622,#05090f)]" />
        <div className="absolute inset-x-8 top-36 h-48 rounded-[40%] bg-[#123049]/50 blur-2xl" />
        <div className="absolute inset-x-10 top-44 grid grid-cols-4 gap-3 opacity-30">
          {Array.from({ length: 12 }).map((_, i) => (
            <div key={i} className="h-10 rounded-md bg-slate-600/40" />
          ))}
        </div>

        <div className="relative z-10 flex items-start justify-between px-4 pt-8">
          <div className="flex items-center gap-2">
            <div className="h-10 w-10 rounded-full bg-gradient-to-br from-sky-300 to-blue-700" />
            <div className="flex h-7 w-7 items-center justify-center rounded-full border border-sky-400/60 text-[10px]">
              Lvl 1
            </div>
          </div>
          <div className="flex items-center gap-2 text-xs text-white/80">
            <span className="rounded-full bg-white/10 px-2 py-1">Jul 9</span>
            <span className="flex h-8 w-8 items-center justify-center rounded-full bg-sky-500/30">
              ↗
            </span>
          </div>
        </div>

        <div className="relative z-10 mx-4 mt-4 rounded-2xl bg-gradient-to-r from-[#8a6a2f] to-[#5c3d18] p-3 shadow-lg">
          <div className="flex items-center gap-3">
            <div className="h-12 w-12 rounded-full bg-[linear-gradient(135deg,#f59e0b,#7c2d12)]" />
            <div>
              <p className="text-[10px] uppercase tracking-[0.16em] text-white/80">
                Nearby side quest
              </p>
              <p className="text-sm font-semibold tracking-wide">STATE STREET STRIDE</p>
              <p className="text-xs text-white/75">0.2 MI · ~30 min · Quest anytime</p>
            </div>
          </div>
        </div>

        <div className="relative z-10 mx-auto mt-16 flex flex-col items-center">
          <div className="h-10 w-16 rounded-full bg-orange-400/80 shadow-[0_20px_40px_rgba(251,146,60,0.45)]" />
          <div className="mt-10 flex h-14 w-14 items-center justify-center rounded-full border-4 border-sky-400 bg-[#1b2733] shadow-[0_0_30px_rgba(56,189,248,0.45)]">
            <svg viewBox="0 0 24 24" className="h-7 w-7 text-slate-300" fill="currentColor" aria-hidden>
              <ellipse cx="12" cy="14" rx="7" ry="5" />
              <circle cx="8" cy="9" r="2.2" />
              <circle cx="16" cy="9" r="2.2" />
              <circle cx="12" cy="7" r="2" />
            </svg>
          </div>
          <span className="mt-1 rounded bg-teal-500/80 px-2 py-0.5 text-[10px]">You</span>
        </div>

        <div className="relative z-10 mt-auto px-4 pb-5">
          <div className="mb-4 flex justify-center gap-4">
            {[
              { label: "Friends", icon: "planet" },
              { label: "Hangout", icon: "rocket" },
              { label: "Capture", icon: "palette" },
            ].map((item) => (
              <div key={item.label} className="flex flex-col items-center gap-1">
                <div className="flex h-14 w-14 items-center justify-center rounded-full border-2 border-sky-400/80 bg-[#0d1a26] shadow-[0_0_20px_rgba(56,189,248,0.25)]">
                  {item.icon === "planet" && (
                    <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" aria-hidden>
                      <circle cx="12" cy="12" r="5" stroke="#7dd3fc" strokeWidth="1.6" />
                      <ellipse cx="12" cy="12" rx="9" ry="3" stroke="#38bdf8" strokeWidth="1.4" />
                    </svg>
                  )}
                  {item.icon === "rocket" && (
                    <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" aria-hidden>
                      <path d="M12 3c3 2 5 6 5 10l-5 5-5-5c0-4 2-8 5-10z" stroke="#7dd3fc" strokeWidth="1.6" />
                      <circle cx="12" cy="11" r="1.5" fill="#7dd3fc" />
                    </svg>
                  )}
                  {item.icon === "palette" && (
                    <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" aria-hidden>
                      <path d="M12 4a8 8 0 1 0 0 16h2a2 2 0 0 0 0-4h-1" stroke="#7dd3fc" strokeWidth="1.6" />
                      <circle cx="8" cy="10" r="1" fill="#7dd3fc" />
                      <circle cx="12" cy="8" r="1" fill="#7dd3fc" />
                      <circle cx="16" cy="10" r="1" fill="#7dd3fc" />
                    </svg>
                  )}
                </div>
                <span className="text-[10px] text-white/70">{item.label}</span>
              </div>
            ))}
          </div>
          <div className="grid grid-cols-3 gap-2">
            <div className="rounded-xl bg-[#12304a] px-2 py-3 text-center text-[11px]">Events</div>
            <div className="rounded-xl bg-[#4c2a78] px-2 py-3 text-center text-[11px]">Messages</div>
            <div className="rounded-xl bg-[#2a241c] px-2 py-3 text-center text-[11px]">Side Quests</div>
          </div>
        </div>
      </div>
    </div>
  );
}

export function BluWorldEventsScreen() {
  const events = [
    {
      title: "A Fab Scavenger Hunt by…",
      meta: "8:00 AM · Greater Madison",
      tag: "Social",
      highlight: true,
    },
    {
      title: "Greenway Station Farmers…",
      meta: "8:00 AM · Greenway Station",
      tag: "Social",
      highlight: false,
    },
    {
      title: "Fluid Mechanics",
      meta: "10:00 AM · Tandem Press",
      tag: "Social",
      highlight: false,
    },
    {
      title: "Frank Lloyd Wright Unita…",
      meta: "10:00 AM · Meeting House",
      tag: "Social",
      highlight: false,
    },
    {
      title: "MATRIX Basements Milli…",
      meta: "11:00 AM · Vitense Golfland",
      tag: "Sports",
      highlight: false,
    },
  ];

  return (
    <div className="phone-frame aspect-[9/19.5] bg-[#070b12] text-white">
      <div className="flex h-full flex-col px-4 pb-5 pt-8">
        <div className="relative mb-4 text-center">
          <div className="absolute left-0 top-0 flex h-9 w-9 items-center justify-center rounded-full bg-white/10">
            ←
          </div>
          <p className="text-lg font-semibold">Madison</p>
          <p className="text-xs text-white/50">Thursday, July 9</p>
        </div>

        <div className="mb-3 flex gap-2 overflow-hidden">
          {["Upcoming", "For You", "School", "Clubs"].map((chip, i) => (
            <span
              key={chip}
              className={`rounded-full px-3 py-1.5 text-[11px] ${
                i === 0 ? "bg-white text-black" : "bg-white/10 text-white/80"
              }`}
            >
              {chip}
            </span>
          ))}
        </div>

        <div className="mb-4 flex justify-center gap-3">
          {["grid", "plus", "search"].map((icon) => (
            <div
              key={icon}
              className="flex h-9 w-9 items-center justify-center rounded-full bg-white/10 text-sm"
            >
              {icon === "grid" ? "▦" : icon === "plus" ? "+" : "⌕"}
            </div>
          ))}
        </div>

        <p className="mb-3 text-sm font-medium text-white/80">Today</p>
        <div className="space-y-2.5 overflow-hidden">
          {events.map((event) => (
            <div
              key={event.title}
              className={`flex items-center gap-3 rounded-2xl bg-[#121821] p-3 ${
                event.highlight
                  ? "shadow-[0_0_0_1px_#3b82f6,0_0_24px_rgba(59,130,246,0.35)]"
                  : ""
              }`}
            >
              <div className="h-11 w-11 shrink-0 rounded-full bg-gradient-to-br from-slate-500 to-slate-800" />
              <div className="min-w-0 flex-1">
                <span
                  className={`inline-block rounded-full px-2 py-0.5 text-[10px] ${
                    event.tag === "Sports"
                      ? "bg-emerald-500/20 text-emerald-300"
                      : "bg-sky-500/20 text-sky-300"
                  }`}
                >
                  {event.tag}
                </span>
                <p className="truncate text-sm font-medium">{event.title}</p>
                <p className="truncate text-[11px] text-white/45">{event.meta}</p>
              </div>
              <span className="text-white/35">›</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
