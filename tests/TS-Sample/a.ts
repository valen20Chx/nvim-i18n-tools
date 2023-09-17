import { t } from "i18n";
import { otherStuff } from "./otherStuff";

function getTheHelloString(): String {
  otherStuff();
  return t("hello.world");
}

function getTheGoodbyeString(): String {
  return t("goodbye.world");
}
