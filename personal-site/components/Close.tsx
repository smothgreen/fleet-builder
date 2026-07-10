"use client";

import { close, site } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function Close() {
  return (
    <section
      id={close.id}
      className="section-pad relative overflow-hidden border-t border-line py-28 md:py-40"
    >
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(ellipse_at_center,rgba(61,139,253,0.18),transparent_60%)]" />
      <div className="relative mx-auto max-w-3xl text-center">
        <Reveal>
          <h2 className="font-display text-4xl tracking-tight text-paper md:text-6xl md:leading-[1.05]">
            {close.title}
          </h2>
          <p className="mx-auto mt-6 max-w-2xl text-base leading-relaxed text-paper-soft md:text-lg">
            {close.body}
          </p>
          <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
            <a
              href={site.x}
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-full bg-paper px-7 py-3.5 text-sm font-medium text-ink transition hover:bg-accent-soft"
            >
              {close.ctaPrimary}
            </a>
            <a
              href={site.linkedin}
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-full border border-line px-7 py-3.5 text-sm text-paper-soft transition hover:border-paper hover:text-paper"
            >
              {close.ctaSecondary}
            </a>
          </div>
        </Reveal>
      </div>
      <footer className="relative mx-auto mt-24 flex max-w-6xl flex-col items-center justify-between gap-3 border-t border-line pt-8 text-sm text-mist md:flex-row">
        <p>© {new Date().getFullYear()} {site.name}</p>
        <p>{site.domain}</p>
      </footer>
    </section>
  );
}
