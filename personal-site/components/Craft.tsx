"use client";

import Image from "next/image";
import { craft } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function Craft() {
  return (
    <section id={craft.id} className="section-pad relative py-28 md:py-36">
      <div className="mx-auto max-w-6xl">
        <Reveal>
          <p className="eyebrow">{craft.eyebrow}</p>
          <h2 className="font-display mt-5 max-w-3xl text-4xl tracking-tight text-paper md:text-5xl">
            {craft.title}
          </h2>
        </Reveal>

        <div className="mt-14 grid gap-12 lg:grid-cols-[1.2fr_0.8fr]">
          <Reveal>
            <div className="overflow-hidden rounded-[1.5rem]">
              <div className="relative aspect-[16/10]">
                <Image
                  src={craft.film.stills[0]}
                  alt="Still from Ice Cold Nikes"
                  fill
                  className="object-cover"
                  sizes="(max-width: 1024px) 100vw, 60vw"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-ink via-transparent to-transparent" />
                <div className="absolute bottom-0 left-0 p-6 md:p-8">
                  <p className="text-sm uppercase tracking-[0.18em] text-warm">
                    Short film
                  </p>
                  <h3 className="font-display mt-2 text-3xl text-paper md:text-4xl">
                    {craft.film.title}
                  </h3>
                  <p className="mt-3 max-w-lg text-sm leading-relaxed text-paper-soft md:text-base">
                    {craft.film.line}
                  </p>
                </div>
              </div>
            </div>
            <div className="mt-3 grid grid-cols-3 gap-3">
              {craft.film.stills.slice(1).map((src) => (
                <div key={src} className="relative aspect-[4/3] overflow-hidden rounded-xl">
                  <Image
                    src={src}
                    alt=""
                    fill
                    className="object-cover"
                    sizes="200px"
                  />
                </div>
              ))}
            </div>
          </Reveal>

          <Reveal delay={0.1} className="flex flex-col justify-center">
            <p className="text-sm uppercase tracking-[0.18em] text-accent-soft">
              Campaign media
            </p>
            <h3 className="font-display mt-4 text-3xl tracking-tight text-paper">
              {craft.campaign.title}
            </h3>
            <p className="mt-5 text-base leading-relaxed text-paper-soft md:text-lg">
              {craft.campaign.line}
            </p>
            <div className="relative mt-10 aspect-[4/5] overflow-hidden rounded-[1.25rem]">
              <Image
                src="/images/craft/film-2.jpg"
                alt="Cinematic portrait still"
                fill
                className="object-cover"
                sizes="(max-width: 1024px) 100vw, 35vw"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-ink/80 to-transparent" />
            </div>
          </Reveal>
        </div>
      </div>
    </section>
  );
}
