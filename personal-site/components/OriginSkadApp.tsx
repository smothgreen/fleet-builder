"use client";

import Image from "next/image";
import { origin } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function OriginSkadApp() {
  return (
    <section id={origin.id} className="section-pad relative bg-ink py-28 pb-20 md:py-36 md:pb-28">
      <div className="mx-auto grid max-w-6xl items-stretch gap-12 lg:grid-cols-2 lg:gap-16">
        <div className="flex h-full flex-col">
          <Reveal>
            <div className="max-w-xl">
              <Image
                src={origin.product.logo}
                alt={origin.product.logoAlt}
                width={1024}
                height={1024}
                className="mx-auto mb-5 block h-auto w-[160px] rounded-2xl sm:mb-6 sm:w-[180px] md:w-[200px]"
                sizes="200px"
              />
              <p className="eyebrow text-center text-skad-soft md:text-left">
                {origin.eyebrow}
              </p>
              <h2 className="font-display mt-5 text-4xl leading-tight tracking-tight text-paper md:text-5xl">
                <span className="block">{origin.titleLines[0]}</span>
                <span className="mt-2 block text-skad-soft">{origin.titleLines[1]}</span>
              </h2>
            </div>
          </Reveal>

          <div className="mt-8 max-w-xl flex-1 space-y-5 text-base leading-relaxed text-paper-soft md:text-lg">
            {origin.body.map((paragraph) => (
              <Reveal key={paragraph.slice(0, 24)}>
                <p>{paragraph}</p>
              </Reveal>
            ))}
          </div>

          <Reveal delay={0.15} className="mt-10 max-w-xl border-l border-skad/50 pl-5 lg:mt-auto lg:pt-10">
            <p className="text-sm uppercase tracking-[0.18em] text-skad-soft">
              {origin.product.name} · {origin.product.feature}
            </p>
            <p className="mt-3 text-paper-soft">{origin.product.featureLine}</p>
          </Reveal>
        </div>

        <Reveal
          delay={0.1}
          className="mx-auto flex w-full max-w-[320px] items-center sm:max-w-[360px] lg:mx-0 lg:ml-auto lg:max-w-[400px]"
        >
          <div className="phone-frame w-full">
            <Image
              src={origin.product.image}
              alt={origin.product.imageAlt}
              width={1206}
              height={2470}
              className="h-auto w-full"
              sizes="(max-width: 1024px) 70vw, 400px"
              priority
            />
          </div>
        </Reveal>
      </div>
    </section>
  );
}
