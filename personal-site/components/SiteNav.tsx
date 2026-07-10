"use client";

import { site, nav } from "@/content/story";
import { useEffect, useState } from "react";

export function SiteNav() {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 40);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <header
      className={`fixed inset-x-0 top-0 z-50 transition-all duration-500 ${
        scrolled
          ? "border-b border-line bg-ink/80 backdrop-blur-xl"
          : "bg-transparent"
      }`}
    >
      <div className="section-pad mx-auto flex h-16 max-w-6xl items-center justify-between">
        <a
          href="#top"
          className="font-display text-lg tracking-tight text-paper transition hover:text-accent-soft"
        >
          {site.name}
        </a>
        <nav className="hidden items-center gap-7 md:flex" aria-label="Primary">
          {nav.map((item) => (
            <a
              key={item.id}
              href={`#${item.id}`}
              className="text-sm text-paper-soft transition hover:text-paper"
            >
              {item.label}
            </a>
          ))}
        </nav>
        <a
          href={`mailto:${site.email}`}
          className="rounded-full border border-line px-4 py-2 text-sm text-paper transition hover:border-accent-soft hover:text-accent-soft"
        >
          Contact
        </a>
      </div>
    </header>
  );
}
