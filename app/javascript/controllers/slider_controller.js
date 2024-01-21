import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage", "thumbnail"]
  currentIndex = 0; // 現在の画像インデックス

  connect() {
    this.showImageAtIndex(this.currentIndex);
  }

  showPreviousImage() {
    this.currentIndex--;
    if (this.currentIndex < 0) {
      this.currentIndex = this.thumbnailTargets.length - 1; // リストの最後に移動
    }
    this.showImageAtIndex(this.currentIndex);
  }

  showNextImage() {
    this.currentIndex++;
    if (this.currentIndex >= this.thumbnailTargets.length) {
      this.currentIndex = 0; // リストの最初に戻る
    }
    this.showImageAtIndex(this.currentIndex);
  }

  showImageAtIndex(index) {
    if (this.thumbnailTargets[index]) {
      const newImageUrl = this.thumbnailTargets[index].dataset.imageUrl;
      if (this.mainImageTarget && newImageUrl) {
        this.mainImageTarget.addEventListener('load', () => {
          this.mainImageTarget.classList.add('opacity-100'); // Tailwind CSSを使用して不透明度を100%に
        }, { once: true });
        this.mainImageTarget.classList.remove('opacity-100'); // 切り替え前に不透明度を0%に
        this.mainImageTarget.src = newImageUrl;
      }
    }
  }

  showImage(event) {
    const newImageUrl = event.currentTarget.dataset.imageUrl;
    if (this.mainImageTarget && newImageUrl) {
      this.mainImageTarget.src = newImageUrl;
      this.currentIndex = this.thumbnailTargets.findIndex(target => target.dataset.imageUrl === newImageUrl);
    }
  }
}