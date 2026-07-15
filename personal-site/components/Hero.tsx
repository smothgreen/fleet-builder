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
      className="relative flex min-h-[100svh] items-end overflow-hidden"
    >
      <motion.div
        className="absolute inset-0 max-md:top-[-18%] max-md:h-[135%]"
        style={{ y: imageY, scale: imageScale }}
      >
        <Image
          src={hero.portrait}
          alt="David Skadron on State Street in Madison"
          fill
          priority
          className="object-cover object-[80%_58%] sm:object-[78%_58%] md:object-[72%_70%]"
          sizes="100vw"
        />
      </motion.div>
      <div className="absolute inset-0 bg-gradient-to-r from-ink via-ink/80 to-ink/30 max-md:opacity-50" />
      <div className="absolute inset-0 bg-gradient-to-t from-ink from-35% via-ink/80 via-55% to-ink/20 md:from-ink md:via-ink/50 md:to-ink/10" />

      <div className="section-pad relative z-10 mx-auto w-full max-w-6xl pb-10 pt-28 md:pb-16 md:pt-32">
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
        <div
          className="hero-enter mt-7 flex flex-wrap items-center gap-3 md:mt-10 md:gap-4"
          style={{ animationDelay: "480ms" }}
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
    </section>
  );
}
