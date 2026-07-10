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
  const imageY = useTransform(scrollYProgress, [0, 1], reduce ? [0, 0] : [0, 120]);
  const imageScale = useTransform(scrollYProgress, [0, 1], reduce ? [1, 1] : [1.08, 1]);
  const contentY = useTransform(scrollYProgress, [0, 1], reduce ? [0, 0] : [0, 60]);
  const opacity = useTransform(scrollYProgress, [0, 0.7], [1, 0.15]);

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
          className="object-cover object-[70%_20%]"
          sizes="100vw"
        />
      </motion.div>
      <div className="absolute inset-0 bg-gradient-to-r from-ink via-ink/75 to-ink/25" />
      <div className="absolute inset-0 bg-gradient-to-t from-ink via-ink/40 to-transparent" />

      <motion.div
        className="section-pad relative z-10 mx-auto w-full max-w-6xl pb-20 pt-32 md:pb-28"
        style={{ y: contentY, opacity }}
      >
        <motion.p
          className="eyebrow mb-6"
          initial={reduce ? false : { opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.7, delay: 0.1 }}
        >
          Builder · Storyteller · Founder
        </motion.p>
        <motion.h1
          className="font-display max-w-3xl text-[clamp(3.2rem,9vw,6.5rem)] leading-[0.92] tracking-[-0.03em] text-paper"
          initial={reduce ? false : { opacity: 0, y: 28 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.9, delay: 0.2, ease: [0.22, 1, 0.36, 1] }}
        >
          {hero.name}
        </motion.h1>
        <motion.p
          className="mt-7 max-w-xl text-lg text-paper-soft md:text-xl md:leading-relaxed"
          initial={reduce ? false : { opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.35 }}
        >
          {hero.thesis}
        </motion.p>
        <motion.p
          className="mt-3 max-w-lg text-base text-mist"
          initial={reduce ? false : { opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.45 }}
        >
          {hero.supporting}
        </motion.p>
        <motion.div
          className="mt-10 flex flex-wrap items-center gap-4"
          initial={reduce ? false : { opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.55 }}
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
        </motion.div>
      </motion.div>
    </section>
  );
}
