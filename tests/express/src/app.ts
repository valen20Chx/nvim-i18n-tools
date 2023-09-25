import express from "express";
import { t } from "i18next";

const app = express();

app.get("/", (_req, res) => {
  const str = t("hello.world");
  res.send(str);
});

export default app;
