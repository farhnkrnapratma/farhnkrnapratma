import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';

export default defineConfig({
  plugins: [pluginReact()],
  html: {
    title: "Farhan Kurnia Pratama",
    meta: {
      description: "Farhan Kurnia Pratama Official Website",
      charset: {
        charset: "UTF-8"
      },
      viewport: "width=device-width, initial-scale=1.0"
    },
  }
});
