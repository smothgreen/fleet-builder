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
  const imageScale = useTransform(scrollYProgress, [0, 1], reduce ? [1, 1] : [1.06, 1]);

  return (
    <section
      id="top"
      ref={ref}
      className="relative flex min-h-[100svh] items-end overflow-hidden"
    >
      <motion.div className="absolute inset-0" style={{ y: imageY, scale: imageScale }}>
        <Image
          src={hero.portrait}
          alt="David Skadron on State Street in Madison"
          fill
          priority
          className="object-cover object-[80%_28%] md:object-[75%_32%]"
          sizes="100vw"
        />
      </motion.div>
      <div className="absolute inset-0 bg-gradient-to-r from-ink via-ink/80 to-ink/30" />
      <div className="absolute inset-0 bg-gradient-to-t from-ink via-ink/50 to-ink/10" />

      <div className="section-pad relative z-10 mx-auto w-full max-w-6xl pb-20 pt-32 md:pb-28">
        <p className="eyebrow hero-enter mb-6" style={{ animationDelay: "80ms" }}>
          Builder · Storyteller · Founder
        </p>
        <h1
          className="font-display hero-enter max-w-3xl text-[clamp(3.2rem,9vw,6.5rem)] leading-[0.92] tracking-[-0.03em] text-paper"
          style={{ animationDelay: "160ms" }}
        >
          {hero.name}
        </h1>
        <p
          className="hero-enter mt-7 max-w-xl text-lg text-paper-soft md:text-xl md:leading-relaxed"
          style={{ animationDelay: "280ms" }}
        >
          {hero.thesis}
        </p>
        <p
          className="hero-enter mt-3 max-w-lg text-base text-mist"
          style={{ animationDelay: "380ms" }}
        >
          {hero.supporting}
        </p>
        <div
          className="hero-enter mt-10 flex flex-wrap items-center gap-4"
          style={{ animationDelay: "480ms" }}
        >
          <a
            href={`mailto:${site.email}`}
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
