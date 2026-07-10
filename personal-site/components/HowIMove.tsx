"use client";

import Image from "next/image";
import { howIMove } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";
import { YouTubeEmbed } from "@/components/YouTubeEmbed";

export function HowIMove() {
  return (
    <section
      id={howIMove.id}
      className="section-pad relative border-y border-line bg-ink-elevated/60 py-28 md:py-36"
    >
      <div className="mx-auto max-w-6xl">
        <Reveal>
          <p className="eyebrow">{howIMove.eyebrow}</p>
          <h2 className="font-display mt-5 max-w-3xl text-4xl tracking-tight text-paper md:text-5xl">
            {howIMove.title}
          </h2>
        </Reveal>

        <div className="mt-16 space-y-16 md:space-y-24">
          {howIMove.beats.map((beat, index) => {
            const reverse = index % 2 === 1;
            const hasYoutube = "youtubeId" in beat && Boolean(beat.youtubeId);

            return (
              <Reveal key={beat.title}>
                <article
                  className={`grid items-center gap-8 md:grid-cols-2 md:gap-14 ${
                    reverse ? "md:[&>*:first-child]:order-2" : ""
                  }`}
                >
                  {hasYoutube ? (
                    <YouTubeEmbed
                      videoId={beat.youtubeId as string}
                      title={beat.title}
                    />
                  ) : (
                    <div className="relative aspect-video overflow-hidden rounded-[1.25rem]">
                      <Image
                        src={beat.image}
                        alt={"imageAlt" in beat ? beat.imageAlt : ""}
                        fill
                        className="object-cover object-center"
                        sizes="(max-width: 768px) 100vw, 50vw"
                      />
                    </div>
                  )}
                  <div>
                    <p className="text-sm text-mist">0{index + 1}</p>
                    <h3 className="font-display mt-3 text-3xl tracking-tight text-paper">
                      {beat.title}
                    </h3>
                    <p className="mt-4 text-base leading-relaxed text-paper-soft md:text-lg">
                      {beat.body}
                    </p>
                    {"url" in beat && beat.url ? (
                      <a
                        href={beat.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="mt-5 inline-flex text-sm text-accent-soft transition hover:text-paper"
                      >
                        {"linkLabel" in beat && beat.linkLabel
                          ? beat.linkLabel
                          : "Open link"}{" "}
                        →
                      </a>
                    ) : null}
                  </div>
                </article>
              </Reveal>
            );
          })}
        </div>
      </div>
    </section>
  );
}
