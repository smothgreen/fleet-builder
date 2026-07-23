"use client";

import Image from "next/image";
import { motion, useReducedMotion, useScroll, useTransform } from "framer-motion";
import { useRef } from "react";
import { hero, site } from "@/content/story";

export function Hero() {
  const ref = useRef<HTMLElement>(null);
  const reduce = useReducedMotion();
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start start", "end start"],
  });
  const imageY = useTransform(scrollYProgress, [0, 1], reduce ? [0, 0] : [0, 100]);
  const imageScale = useTransform(scrollYProgress, [0, 1], reduce ? [1, 1] : [1, 0.98]);

  return (
    <section
      id="top"
      ref={ref}
      className="relative flex min-h-[100svh] flex-col overflow-hidden md:block"
    >
      {/* Photo — own upper band on mobile so the face clears the copy */}
      <motion.div
        className="relative h-[58svh] w-full shrink-0 md:absolute md:inset-0 md:h-auto"
        style={{ y: imageY, scale: imageScale }}
      >
        <Image
          src={hero.portrait}
          alt="David Skadron on State Street in Madison"
          fill
          priority
          className="object-cover object-[78%_28%] sm:object-[78%_36%] md:object-[72%_66%]"
          sizes="100vw"
        />
        <div className="absolute inset-x-0 bottom-0 h-[55%] bg-gradient-to-b from-transparent via-ink/55 to-ink md:hidden" />
        <div className="absolute inset-0 bg-gradient-to-b from-ink/25 to-transparent md:hidden" />
        <div className="absolute inset-0 hidden bg-gradient-to-r from-ink via-ink/80 to-ink/30 md:block" />
        <div className="absolute inset-0 hidden bg-gradient-to-t from-ink via-ink/50 to-ink/10 md:block" />
      </motion.div>

      {/* Copy — lower band on mobile, bottom-left overlay on desktop */}
      <div className="relative z-10 flex flex-col justify-start bg-ink px-0 pb-10 pt-5 md:absolute md:inset-0 md:justify-end md:bg-transparent md:pb-16 md:pt-32">
        <div className="section-pad mx-auto w-full max-w-6xl">
          <p className="eyebrow hero-enter mb-4 md:mb-6" style={{ animationDelay: "80ms" }}>
            Builder · Founder · Human
          </p>
          <h1
            className="font-display hero-enter max-w-3xl text-[clamp(2.6rem,11vw,6.5rem)] leading-[0.92] tracking-[-0.03em] text-paper"
            style={{ animationDelay: "160ms" }}
          >
            {hero.name}
          </h1>
          <p
            className="hero-enter mt-4 max-w-xl text-base text-paper-soft md:mt-7 md:text-xl md:leading-relaxed"
            style={{ animationDelay: "280ms" }}
          >
            {hero.thesis}
          </p>
          <p
            className="hero-enter mt-2 max-w-lg text-sm text-mist md:mt-3 md:text-base"
            style={{ animationDelay: "380ms" }}
          >
            {hero.supporting}
          </p>
          <blockquote
            className="hero-enter mt-6 max-w-md border-t border-line/60 pt-5 md:mt-8 md:pt-6"
            style={{ animationDelay: "440ms" }}
          >
            <p className="font-display text-[0.95rem] italic leading-snug text-paper-soft md:text-lg md:leading-relaxed">
              “{hero.quote}”
            </p>
            <cite className="mt-2 block text-xs not-italic tracking-wide text-mist md:text-sm">
              — {hero.quoteAttribution}
            </cite>
          </blockquote>
          <div
            className="hero-enter mt-7 flex flex-wrap items-center gap-3 md:mt-10 md:gap-4"
            style={{ animationDelay: "520ms" }}
          >
            <a
              href={site.x}
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-full bg-paper px-6 py-3 text-sm font-medium text-ink transition hover:bg-accent-soft"
            >
              {hero.cta}
            </a>
            <a
              href="#skadapp"
              className="rounded-full border border-line px-6 py-3 text-sm text-paper-soft transition hover:border-paper hover:text-paper"
            >
              See the work
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
