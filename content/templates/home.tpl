<apply template="base">
  <bind tag="body-main">
    <div class="container max-w-screen-md mx-auto mt-8 flex flex-col items-center justify-center">
      <bind tag="cardClass">rounded-lg shadow-md m-4 bg-white </bind>
      <bind tag="cardSmallClass">rounded-lg hover:shadow-md m-4 hover:bg-white flex-shrink-0 </bind>
      <bind tag="linkClass">underline</bind>

      <!-- Topmost card -->
      <div style="max-width: 40em;" class="${cardClass} px-4 py-6 flex flex-col items-center justify-center space-y-4">
        <div class="w-32 flex-shrink-0">
          <ema:metadata>
            <with var="template">
              <img src="${value:iconUrl}" class="rounded-full object-cover">
            </with>
          </ema:metadata>
        </div>
        <div class="flex flex-col items-start space-y-1 h-full">
          <header class="text-2xl">Hey, I'm Srid. 👋 </header>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex flex-row justify-center">
        <a href="-/all" class="${cardSmallClass} w-12 p-2" title="Public notes">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
          </svg>
        </a>
        <a class="${cardSmallClass} w-12 p-2" href="https://github.com/srid" title="GitHub profile" target="_blank">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path
              d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
          </svg>
        </a>
        <a class="${cardSmallClass} w-12 p-2" href="https://srid.substack.com/" title="Newsletter" target="_blank">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 606 606" preserveAspectRatio="xMidYMid meet">
            <path style="fill:#ff6719; stroke:none;"
              d="M35 4L35 75L564 75L564 4L35 4M35 139L35 211L564 211L564 139L35 139M35 274L35 605C56.6208 598.76 78.3422 581.827 98 570.86L230 497.14C246.343 488.022 262.731 478.968 279 469.719C284.318 466.696 293.313 459.172 299.576 459.286C305.748 459.399 314.711 466.977 320 469.999C335.238 478.708 350.615 487.245 366 495.694C412.513 521.239 458.488 547.761 505 573.306C522.985 583.183 543.997 600.423 564 605L564 274L35 274z" />
          </svg>
        </a>

      </div>
    </div>
  </bind>
</apply>