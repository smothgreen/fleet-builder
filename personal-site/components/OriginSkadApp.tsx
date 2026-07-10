"use client";

import Image from "next/image";
import { origin } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function OriginSkadApp() {
  return (
    <section id={origin.id} className="section-pad relative py-28 md:py-36">
      <div className="mx-auto grid max-w-6xl items-center gap-14 lg:grid-cols-[1.05fr_0.95fr]">
        <div>
          <Reveal>
            <p className="eyebrow">{origin.eyebrow}</p>
            <h2 className="font-display mt-5 max-w-xl text-4xl leading-tight tracking-tight text-paper md:text-5xl">
              {origin.title}
            </h2>
          </Reveal>
          <div className="mt-8 max-w-xl space-y-5 text-base leading-relaxed text-paper-soft md:text-lg">
            {origin.body.map((paragraph) => (
              <Reveal key={paragraph.slice(0, 24)}>
                <p>{paragraph}</p>
              </Reveal>
            ))}
          </div>
          <Reveal delay={0.15} className="mt-10 border-l border-accent/40 pl-5">
            <p className="text-sm uppercase tracking-[0.18em] text-mist">
              {origin.product.name} · {origin.product.feature}
            </p>
            <p className="mt-3 max-w-md text-paper-soft">{origin.product.featureLine}</p>
          </Reveal>
        </div>

        <Reveal delay={0.1} className="mx-auto w-full max-w-[320px] lg:max-w-[360px]">
          <div className="phone-frame">
            <Image
              src={origin.product.image}
              alt={origin.product.imageAlt}
              width={720}
              height={1480}
              className="h-auto w-full"
              sizes="(max-width: 768px) 80vw, 360px"
            />
          </div>
        </Reveal>
      </div>
    </section>
  );
}
