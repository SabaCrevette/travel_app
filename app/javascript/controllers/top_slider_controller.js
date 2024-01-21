import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["lineA", "lineB"];

  connect() {
    this.loadImages();
  }

  loadImages(images) {
    this.setImagesToLine(this.lineATarget, images.slice(0, 30));
    this.setImagesToLine(this.lineBTarget, images.slice(30, 60));
  }

  setImagesToLine(line, imageUrls) {
    imageUrls.forEach(url => {
      const imgElement = document.createElement('img');
      imgElement.src = url;
      imgElement.classList.add('slider-image', 'inline-block'); // 'slider-image' クラスを追加
      line.appendChild(imgElement);
    });
    this.startSliding();
  }

  // スライダーのアニメーションを制御するメソッド
  startSliding() {
    this.lineATarget.style.animationPlayState = 'running';
    this.lineBTarget.style.animationPlayState = 'running';
  }
}
