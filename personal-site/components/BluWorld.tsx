"use client";

import Image from "next/image";
import { bluworld } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function BluWorld() {
  const [sideQuestScreen, eventsScreen, mapScreen] = bluworld.screens;

  return (
    <section
      id={bluworld.id}
      className="section-pad relative isolate overflow-hidden bg-ink pt-28 pb-28 md:pt-36 md:pb-36"
    >
      <div className="relative mx-auto grid max-w-4xl gap-x-10 gap-y-12 sm:grid-cols-2 lg:gap-x-14 lg:gap-y-16">
        <Reveal className="mx-auto flex w-full max-w-[320px] items-center sm:mx-0 sm:max-w-none sm:self-center">
          <Image
            src={bluworld.globe}
            alt="BluWorld globe"
            width={840}
            height={840}
            className="aspect-square h-auto w-full rounded-[2.5rem] shadow-[0_0_60px_-12px_rgba(56,189,248,0.35)]"
            sizes="(max-width: 640px) 320px, 420px"
          />
        </Reveal>

        <Reveal delay={0.08}>
          <p className="eyebrow">{bluworld.eyebrow}</p>
          <h2 className="font-display mt-5 text-4xl tracking-tight text-paper md:text-5xl">
            {bluworld.title}
          </h2>
          <p className="mt-5 text-lg text-paper-soft md:text-xl md:leading-snug">
            {bluworld.subtitle}
          </p>
          <p className="mt-5 text-base leading-relaxed text-mist">
            {bluworld.body}
          </p>
          <a
            href={bluworld.appStoreUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-8 inline-flex items-center gap-2 rounded-full border border-line px-5 py-2.5 text-sm text-paper-soft transition hover:border-paper hover:text-paper"
          >
            <AppleIcon />
            Download on the App Store
          </a>
        </Reveal>

        {[sideQuestScreen, eventsScreen].map((screen, index) => (
          <Reveal key={screen.src} delay={index * 0.08}>
            <figure className="w-full">
              <div className="phone-frame">
                <Image
                  src={screen.src}
                  alt={screen.alt}
                  width={507}
                  height={1024}
                  className="h-auto w-full"
                  sizes="(max-width: 640px) 78vw, 420px"
                />
              </div>
              <figcaption className="mt-4 text-center text-sm text-mist">
                {screen.caption}
              </figcaption>
            </figure>
          </Reveal>
        ))}

        <Reveal delay={0.16} className="sm:col-span-2">
          <figure>
            <div className="overflow-hidden rounded-[2rem] border border-line bg-black shadow-[0_30px_80px_rgba(0,0,0,0.45)]">
              <Image
                src={mapScreen.src}
                alt={mapScreen.alt}
                width={720}
                height={1480}
                className="h-auto w-full"
                sizes="(max-width: 768px) 92vw, 896px"
              />
            </div>
            <figcaption className="mt-4 text-center text-sm text-mist">
              {mapScreen.caption}
            </figcaption>
          </figure>
        </Reveal>
      </div>
    </section>
  );
}

function AppleIcon() {
  return (
    <svg viewBox="0 0 16 16" className="h-4 w-4" fill="currentColor" aria-hidden>
      <path d="M12.7 8.4c0-1.7 1.4-2.5 1.5-2.6-.8-1.2-2.1-1.3-2.5-1.4-1.1-.1-2 .6-2.6.6-.6 0-1.4-.6-2.3-.6-1.2 0-2.3.7-2.9 1.8-1.2 2.2-.3 5.4.9 7.1.6.9 1.3 1.8 2.2 1.8.9 0 1.2-.6 2.3-.6s1.4.6 2.3.6c1 0 1.6-.9 2.2-1.7.7-1 1-2 1-2.1-.1 0-1.8-.7-1.8-2.9zM10.6 3.3c.5-.6.8-1.4.7-2.2-.7 0-1.5.5-2 .1-.4.5-.9 1.4-.8 2.2.8.1 1.6-.4 2.1-1.1z" />
    </svg>
  );
}
