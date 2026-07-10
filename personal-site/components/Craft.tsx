"use client";

import Image from "next/image";
import { craft } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";
import { YouTubeEmbed } from "@/components/YouTubeEmbed";

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
            <YouTubeEmbed
              videoId={craft.film.youtubeId}
              title={`${craft.film.title} — award-winning short film by David Skadron`}
            />
            <div className="mt-5">
              <p className="text-sm uppercase tracking-[0.18em] text-warm">Short film</p>
              <h3 className="font-display mt-2 text-3xl text-paper md:text-4xl">
                {craft.film.title}
              </h3>
              <p className="mt-3 max-w-lg text-sm leading-relaxed text-paper-soft md:text-base">
                {craft.film.line}
              </p>
              <a
                href={craft.film.url}
                target="_blank"
                rel="noopener noreferrer"
                className="mt-4 inline-flex text-sm text-accent-soft transition hover:text-paper"
              >
                Watch on YouTube →
              </a>
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
            <a
              href={craft.campaign.xUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="group relative mt-8 block overflow-hidden rounded-[1.25rem]"
            >
              <div className="relative aspect-[9/14]">
                <Image
                  src={craft.campaign.poster}
                  alt="Dean Phillips campaign video by David Skadron"
                  fill
                  className="object-cover transition duration-500 group-hover:scale-[1.03]"
                  sizes="(max-width: 1024px) 100vw, 35vw"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-ink via-ink/30 to-transparent" />
                <div className="absolute inset-0 flex items-center justify-center">
                  <span className="flex h-16 w-16 items-center justify-center rounded-full bg-paper/95 text-ink shadow-lg">
                    ▶
                  </span>
                </div>
                <div className="absolute bottom-0 left-0 p-5">
                  <p className="text-sm text-paper-soft">Viral campaign video on X</p>
                  <p className="mt-1 text-paper">Watch the cut →</p>
                </div>
              </div>
            </a>
          </Reveal>
        </div>
      </div>
    </section>
  );
}
