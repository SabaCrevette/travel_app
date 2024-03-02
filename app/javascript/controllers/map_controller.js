import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateClasses();
  }

  updateClasses() {
    const paths = this.element.querySelectorAll('path');

    paths.forEach(path => {
      this.setRandomInterval(path);
    });
  }

  setRandomInterval(path) {
    const changeClass = () => {
      // 以前のクラスを削除
      for (let i = 0; i <= 3; i++) {
        path.classList.remove('top-count-' + i);
      }

      // ランダムなクラスを追加
      const randomClass = 'top-count-' + Math.floor(Math.random() * 4);
      path.classList.add(randomClass);

      // 次のクラス変更までのランダムな待機時間を設定
      setTimeout(changeClass, Math.random() * 7000 + 3000);
    };

    // 初回の実行
    changeClass();
  }
}

// メモ
// Math.random()  0以上1未満のランダムな浮動小数点数を生成
// 上記に*4で0以上4未満の値となる。
// Math.floorで小数点以下を切り捨てる（下に丸める）

// setTimeout(changeClass, Math.random() * 7000 + 3000);
// Math.randomで与えられたランダムな数値0以上1未満が生成、ここに7000をかけることで、
// 0以上7000未満の数値ができる。ここに3000を足すことで、
// 3000mm秒（3秒）〜9999mm秒（ほぼ10秒）の間でランダムなchangeClassの実行ができる