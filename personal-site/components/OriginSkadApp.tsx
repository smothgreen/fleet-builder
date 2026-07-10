"use client";

import Image from "next/image";
import { origin } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function OriginSkadApp() {
  return (
    <section id={origin.id} className="section-pad relative py-28 md:py-36">
      <div className="mx-auto grid max-w-6xl items-start gap-12 lg:grid-cols-[1.05fr_0.95fr] lg:gap-16">
        <div className="flex flex-col">
          <Reveal>
            <div className="max-w-xl">
              <Image
                src={origin.product.logo}
                alt={origin.product.logoAlt}
                width={1024}
                height={1024}
                className="mx-auto mb-5 block h-auto w-[160px] rounded-2xl sm:mb-6 sm:w-[200px] md:mx-0 md:w-[220px]"
                sizes="220px"
              />
              <p className="eyebrow text-skad-soft">{origin.eyebrow}</p>
              <h2 className="font-display mt-5 text-4xl leading-tight tracking-tight text-paper md:text-5xl">
                <span className="block">{origin.titleLines[0]}</span>
                <span className="mt-2 block text-skad-soft">{origin.titleLines[1]}</span>
              </h2>
            </div>
          </Reveal>
          <div className="mt-8 max-w-xl space-y-5 text-base leading-relaxed text-paper-soft md:text-lg">
            {origin.body.map((paragraph) => (
              <Reveal key={paragraph.slice(0, 24)}>
                <p>{paragraph}</p>
              </Reveal>
            ))}
          </div>
        </div>

        <Reveal delay={0.1} className="mx-auto w-full max-w-[320px] lg:mx-0 lg:ml-auto lg:max-w-[360px]">
          <div className="phone-frame w-full">
            <Image
              src={origin.product.image}
              alt={origin.product.imageAlt}
              width={1206}
              height={2470}
              className="h-auto w-full"
              sizes="(max-width: 1024px) 70vw, 360px"
              priority
            />
          </div>
          <div className="mt-5 border-l border-skad/50 pl-5">
            <p className="text-sm uppercase tracking-[0.18em] text-skad-soft">
              {origin.product.name} · {origin.product.feature}
            </p>
            <p className="mt-3 text-paper-soft">{origin.product.featureLine}</p>
          </div>
        </Reveal>
      </div>
    </section>
  );
}
