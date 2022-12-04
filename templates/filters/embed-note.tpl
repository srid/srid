<section title="Embedded content" class="bg-white transform rounded-lg shadow hover:shadow-lg hover:scale-105 flex-1 mx-4 my-8 cursor-pointer overflow-hidden overflow-ellipsis max-h-96" onclick="window.location='${ema:note:url}'">
  <header
    class="flex items-center text-2xl text-gray-700 italic rounded-t-lg bg-${theme}-100 py-2.5 px-3 mb-3">
    <a href="${ema:note:url}">
      <ema:note:title />
    </a>
  </header>
  <div class="p-3">
    <apply template="/templates/components/pandoc" />
  </div>
</section>