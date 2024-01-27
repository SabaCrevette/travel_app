import { Autocomplete } from "stimulus-autocomplete";

export default class extends Autocomplete {
  connect() {
    super.connect();
    this.selectedTags = [];
    console.log("TagAutocompleteController connected");
    // ここで必要な初期化処理を行います。Turboによるページ遷移後も、このメソッドは呼び出されます。
  }

  // タグ入力時の処理
  onInputChange(event) {
    console.log("Input changed", event.target.value);
    const inputValue = this.inputTarget.value.trim();
    const lastTag = inputValue.split(" ").pop();

    if (lastTag.length > 0) {
      this.element.setAttribute('data-autocomplete-url-value', this.originalUrl + `?q=${encodeURIComponent(lastTag)}`);
      super.onInputChange(event); // 親クラスのonInputChangeメソッドを呼び出して、オートコンプリート機能を利用します。
    }
  }

  // タグ選択時の処理
  select(event) {
    console.log("Tag selected", event.detail);
    super.select(event); // 必要に応じて、親クラスのselectメソッドを呼び出します。

    const [value, label] = event.detail;
    this.selectedTags.push(label);
    this.inputTarget.value = this.selectedTags.join(" ") + " ";
    this.clearResults();
    this.inputTarget.focus();
  }
}
