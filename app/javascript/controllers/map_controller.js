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
      const randomClass = 'top-count-' + Math.floor(Math.random() * 5);
      path.classList.add(randomClass);

      // 次のクラス変更までのランダムな待機時間を設定
      setTimeout(changeClass, Math.random() * (10000 - 3000) + 3000);
    };

    // 初回の実行
    changeClass();
  }
}
