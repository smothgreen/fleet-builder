"use client";

import { education, experience } from "@/content/story";
import { Reveal } from "@/components/Motion/Reveal";

export function Experience() {
  return (
    <section className="section-pad relative py-28 md:py-36">
      <div className="mx-auto grid max-w-6xl gap-16 lg:grid-cols-[1fr_1fr]">
        <div>
          <Reveal>
            <p className="eyebrow">{experience.eyebrow}</p>
            <h2 className="font-display mt-5 text-3xl tracking-tight text-paper md:text-4xl">
              Places I learned to ship judgment.
            </h2>
          </Reveal>
          <ol className="mt-10 space-y-0">
            {experience.items.map((item, index) => (
              <Reveal key={item.org} delay={index * 0.05}>
                <li className="border-t border-line py-6">
                  <div className="flex flex-wrap items-baseline justify-between gap-2">
                    <h3 className="text-lg text-paper">{item.role}</h3>
                    <span className="text-sm text-mist">{item.year}</span>
                  </div>
                  <p className="mt-1 text-accent-soft">{item.org}</p>
                  <p className="mt-2 text-sm leading-relaxed text-paper-soft">
                    {item.line}
                  </p>
                </li>
              </Reveal>
            ))}
          </ol>
        </div>

        <Reveal delay={0.1}>
          <div className="rounded-[1.5rem] border border-line bg-slate/40 p-8 md:p-10">
            <p className="eyebrow">Education</p>
            <h3 className="font-display mt-4 text-3xl tracking-tight text-paper">
              {education.school}
            </h3>
            <p className="mt-4 text-base leading-relaxed text-paper-soft">
              {education.detail}
            </p>
            <ul className="mt-8 space-y-3">
              {education.highlights.map((item) => (
                <li
                  key={item}
                  className="border-t border-line pt-3 text-sm text-mist first:border-t-0 first:pt-0"
                >
                  {item}
                </li>
              ))}
            </ul>
          </div>
        </Reveal>
      </div>
    </section>
  );
}
