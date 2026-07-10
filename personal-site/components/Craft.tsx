"use client";

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

        <Reveal className="mx-auto mt-14 max-w-3xl">
          <YouTubeEmbed
            videoId={craft.film.youtubeId}
            title={`${craft.film.title} — award-winning short film by David Skadron`}
          />
          <div className="mt-6">
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
      </div>
    </section>
  );
}
