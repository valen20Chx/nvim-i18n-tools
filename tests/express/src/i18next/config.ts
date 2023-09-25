import i18next from "i18next";
import en from "./locales/en/translation.json";

i18next.init({
  lng: "en",
  resources: {
    en: {
      translation: en,
    },
  },
});
