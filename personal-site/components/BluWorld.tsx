"use client";

import Image from "next/image";
import { bluworld } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";
import { motion, useReducedMotion, useScroll, useTransform } from "framer-motion";
import { useRef } from "react";

export function BluWorld() {
  const ref = useRef<HTMLElement>(null);
  const reduce = useReducedMotion();
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start end", "end start"],
  });
  const globeY = useTransform(scrollYProgress, [0, 1], reduce ? [0, 0] : [80, -80]);
  const globeOpacity = useTransform(scrollYProgress, [0, 0.3, 0.8], [0.15, 0.35, 0.2]);

  return (
    <section
      id={bluworld.id}
      ref={ref}
      className="section-pad relative overflow-hidden border-y border-line py-28 md:py-36"
    >
      <motion.div
        className="pointer-events-none absolute -right-24 top-10 hidden w-[420px] opacity-40 md:block"
        style={{ y: globeY, opacity: globeOpacity }}
      >
        <Image
          src={bluworld.globe}
          alt=""
          width={840}
          height={840}
          className="h-auto w-full"
          aria-hidden
        />
      </motion.div>

      <div className="relative mx-auto max-w-6xl">
        <Reveal>
          <p className="eyebrow">{bluworld.eyebrow}</p>
          <h2 className="font-display mt-5 text-4xl tracking-tight text-paper md:text-6xl">
            {bluworld.title}
          </h2>
          <p className="mt-5 max-w-2xl text-xl text-paper-soft md:text-2xl md:leading-snug">
            {bluworld.subtitle}
          </p>
          <p className="mt-5 max-w-2xl text-base leading-relaxed text-mist md:text-lg">
            {bluworld.body}
          </p>
        </Reveal>

        <div className="mt-16 grid gap-8 md:grid-cols-3">
          <Reveal>
            <figure className="mx-auto max-w-[280px] md:max-w-none">
              <div className="phone-frame">
                <Image
                  src="/images/bluworld/sidequest.png"
                  alt="BluWorld home with State Street side quest"
                  width={501}
                  height={1024}
                  className="h-auto w-full"
                  sizes="(max-width: 768px) 70vw, 280px"
                />
              </div>
              <figcaption className="mt-4 text-center text-sm text-mist">
                Side quests — cool things to do in any city
              </figcaption>
            </figure>
          </Reveal>
          <Reveal delay={0.08}>
            <figure className="mx-auto max-w-[280px] md:max-w-none">
              <div className="phone-frame">
                <Image
                  src="/images/bluworld/events.png"
                  alt="BluWorld Madison events feed"
                  width={507}
                  height={1024}
                  className="h-auto w-full"
                  sizes="(max-width: 768px) 70vw, 280px"
                />
              </div>
              <figcaption className="mt-4 text-center text-sm text-mist">
                Events that pull you outside
              </figcaption>
            </figure>
          </Reveal>
          <Reveal delay={0.16}>
            <figure className="mx-auto max-w-[280px] md:max-w-none">
              <div className="phone-frame">
                <Image
                  src="/images/bluworld/map-home.png"
                  alt="BluWorld map home screen"
                  width={720}
                  height={1480}
                  className="h-auto w-full"
                  sizes="(max-width: 768px) 70vw, 280px"
                />
              </div>
              <figcaption className="mt-4 text-center text-sm text-mist">
                A living map of adventure
              </figcaption>
            </figure>
          </Reveal>
        </div>
      </div>
    </section>
  );
}
