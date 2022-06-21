<apply template="base">
  <bind tag="body-main">
    <div class="container max-w-screen-md mx-auto my-8 flex flex-col items-center justify-center">
      <bind tag="linkClass">underline</bind>

      <div class="bg-white rounded-lg shadow-md w-full flex flex-col space-y-4 text-gray-600">
        <div id="__TOP__"
          class="flex flex-row items-start justify-between space-x-4 w-full px-4 py-6 rounded-t bg-pink-600 text-white">
          <div>
            <header class="font-bold text-3xl">
              Sridhar Ratnakumar
            </header>
            <div class="text-gray-100">
              <a class="${linkClass}" title="EST"
                href="https://www.timeanddate.com/time/zone/canada/quebec-province">Quebec
                City</a>, Canada
            </div>
            <div class="font-bold mt-4">
              Senior Software Engineer (Haskell, Nix)
            </div>
          </div>
          <div class="w-24">
            <ema:metadata>
              <with var="template">
                <img src="${value:iconUrl}" class="rounded-full object-cover">
              </with>
            </ema:metadata>
          </div>
        </div>

        <div id="__SUMMARY__" class="px-4 py-4  flex flex-col space-y-4 text-xl text-gray-900 font-bold">
          <p class="leading-snug">
            I became passionate of programming computers in 2001 and explored various technologies before
            discovering Haskell (around 2017) which remains my current tool of choice for
            writing software along with <b>Nix</b>. Nowadays I'm
            also excited about purely functional programming as well as type systems.
          </p>
        </div>

        <div id="__MAIN__" class="px-4 py-6 flex flex-col space-y-4 pt-4 text-gray-600">
          <section>
            <apply template="cv/company">Open Source</apply>
            <p class="font-serif mb-2">Writing open source code has been a golden thread throughout my career. Lately
              I'm
              proud of these
              software written primarily in Haskell:</p>
            <ul class="list-disc pl-4 mb-2 space-y-1">
              <li><a class="${linkClass}" href="https://ema.srid.ca">Ema</a></li>
              <li><a class="${linkClass}" href="https://neuron.zettel.page">Neuron</a></li>
              <li><a class="${linkClass}" href="https://emanote.srid.ca">Emanote</a></li>
            </ul>
            <p class="font-serif">Visit <a class="${linkClass}" href="https://github.com/srid">my GitHub profile</a> for
              a full portfolio of projects.</p>
          </section>
          <section>
            <apply template="cv/company">Self-employed</apply>
            <p class="font-serif mb-2">‣ Since <apply template="cv/year">2018</apply> I've been self-employed as an
              independent
              contractor working
              primarily on Haskell
              projects
              with Nix involved as necessary. At <em>Obsidian Systems</em>, and for other clients, I
              worked on Reflex / GHCJS projects writing full-stack apps in Haskell. </p>
            <p class="font-serif mb-2">‣ During <apply template="cv/year">2020</apply>-<apply template="cv/year">2021
              </apply>
              ,
              I briefly explored
              a couple of experimental indie projects including <a class="${linkClass}"
                href="cerveau-announce">Cerveau</a>, a Reflex full-stack app for note-taking. <a class="${linkClass}"
                href="https://ema.srid.ca">Ema</a> was the unintended result of the other one.</p>
            <p class="font-serif">‣ From late <apply template="cv/year">2021</apply>, I joined <em>Platonic
                Systems</em>
              and began working on
              Cardano blockchain projects,
              including the
              <a class="${linkClass}" href="https://github.com/Plutonomicon/plutarch/graphs/contributors">Plutarch</a>
              programming language.
            </p>
          </section>
          <section>
            <apply template="cv/company">Prior roles</apply>
            <p class="font-serif">
              My previous roles (all full-time) include <em>Microsoft</em> (<apply template="cv/year">2008</apply>-
              <apply template="cv/year">2009</apply>), <em>ActiveState</em> (<apply template="cv/year">2009</apply>-
              <apply template="cv/year">2014</apply>) and <em>Heroku</em>. At ActiveState, I worked on a package manager
              for
              the
              company's Python distribution (ActivePython) and later took on working on its platform-as-a-service (Paas)
              product, which included creating a log aggregation component in Go. That type of work (log aggregation)
              continued on with Heroku, on its logplex and related projects. Clojure, Ruby, Elixir and Erlang were some
              of
              the other languages I used professionally during these years. After Heroku, I took a year long sabattical
              to visit my folks in India, followed by another year of immersing myself in the Quebec culture.
            </p>
          </section>
        </div>

        <div id="__ASIDE__" class="bg-pink-50 px-4 py-6 flex flex-col space-y-4 pt-4 text-gray-600">
          <section>
            <apply template="cv/company">Misc facts</apply>
            <p>I'm multilingual—I speak Tamil (native), English and French. I did my batchelors in computer science in
              India and immigrated to Canada in 2008. I'm interested in all things related to <a class="${linkClass}"
                href="free">consciousness</a>.
            </p>
          </section>
        </div>

      </div>
    </div>
  </bind>
</apply>