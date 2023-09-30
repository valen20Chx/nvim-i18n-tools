import "./App.css";
import i18n from "i18next";
import { initReactI18next, useTranslation } from "react-i18next";
import en from "./locales/en/translation.json";

i18n.use(initReactI18next).init({
  resources: {
    en: {
      translation: en,
    },
  },
  lng: "en",
  fallbackLng: "en",

  interpolation: {
    escapeValue: false,
  },
});

function App() {
  const { t } = useTranslation();

  return <h1>{t("hello.world")}</h1>;
}

export default App;
