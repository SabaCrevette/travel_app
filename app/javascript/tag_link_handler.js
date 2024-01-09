// document.addEventListener("DOMContentLoaded", function() {
//   // タグリンクをすべて取得
//   var tagLinks = document.querySelectorAll('.tag-link');

//   // 各タグリンクに対してクリックイベントリスナーを設定
//   tagLinks.forEach(function(link) {
//     link.addEventListener('click', function(event) {
//       event.preventDefault();

//       // 現在のURLから既存のタグ名を取得
//       var currentTags = new URLSearchParams(window.location.search).get('tag_name');
//       var newTag = this.getAttribute('data-tag-name');

//       // 既存のタグ名に新しいタグ名を追加
//       var updatedTags = currentTags ? currentTags + '+' + newTag : newTag;

//       // 新しいURLに更新
//       window.location.href = '/search?tag_name=' + encodeURIComponent(updatedTags) + '#posts-list-section';
//     });
//   });
// });
