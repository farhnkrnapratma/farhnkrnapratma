<template>
    <div class="w-full h-full absolute top-0 left-0 p-3 bg-bg">
        <div
            class="w-full h-full border border-bg2 rounded-lg grid [grid-template-columns:15%_85%] [grid-template-rows:4%_96%] p-3 bg-bg whitespace-nowrap"
        >
            <div
                class="col-span-full bg-bg rounded-sm grid grid-cols-2 grid-rows-1"
            >
                <div
                    class="col-span-1 row-span-1 inline-flex items-center w-full h-full"
                >
                    <ul class="list-none inline-flex ml-2 hlist">
                        <li
                            class="bi bi-layout-sidebar-inset"
                            tabindex="0"
                        ></li>
                        <li tabindex="0">File</li>
                        <li tabindex="0">Edit</li>
                        <li tabindex="0">View</li>
                        <li tabindex="0">Sort</li>
                    </ul>
                </div>
                <div
                    class="col-span-1 row-span-1 inline-flex items-center justify-end w-full h-full"
                >
                    <ul class="list-none inline-flex mr-2 hlist">
                        <li class="bi bi-search" tabindex="0"></li>
                        <li class="bi bi-x-lg" tabindex="0"></li>
                    </ul>
                </div>
            </div>
            <div class="bg-bg0_s rounded-xl">
                <ul class="list-none mlist">
                    <li tabindex="0">
                        <i class="bi bi-clock-history"></i>Recents
                    </li>
                    <li tabindex="0"><i class="bi bi-house"></i>Home</li>
                    <li tabindex="0">
                        <i class="bi bi-file-text"></i>Documents
                    </li>
                    <li tabindex="0">
                        <i class="bi bi-file-earmark-arrow-down"></i>Downloads
                    </li>
                    <li tabindex="0">
                        <i class="bi bi-music-note-beamed"></i>Music
                    </li>
                    <li tabindex="0"><i class="bi bi-image"></i>Pictures</li>
                    <li tabindex="0">
                        <i class="bi bi-person-workspace"></i>Projects
                    </li>
                    <li tabindex="0"><i class="bi bi-share"></i>Public</li>
                    <li tabindex="0"><i class="bi bi-copy"></i>Templates</li>
                    <li tabindex="0"><i class="bi bi-play-btn"></i>Videos</li>
                    <hr
                        class="rounded-md h-[1px] bg-bg2 border-none m-3 ml-6 mr-6"
                    />
                    <li tabindex="0"><i class="bi bi-trash"></i>Trash</li>
                    <hr
                        class="rounded-md h-[1px] bg-bg2 border-none m-3 ml-6 mr-6"
                    />
                    <li tabindex="0">
                        <i class="bi bi-globe-americas"></i>Networks
                    </li>
                </ul>
            </div>
            <div class="bg-bg"></div>
        </div>
    </div>
</template>
