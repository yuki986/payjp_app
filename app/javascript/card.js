const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);  // 環境変数を読み込む
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {  // イベント発火
    e.preventDefault();

    // カードの情報の取得先
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
                          //↑formの要素はname属性から持ってくる
    const card = {
      number: formData.get("number"),               // カード番号
      cvc: formData.get("cvc"),                    // カードの3桁の番号
      exp_month: formData.get("exp_month"),        // 有効期限の月
      exp_year: `20${formData.get("exp_year")}`,   // 有効期限の年
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");   //idを元に要素を取得
        const tokenObj = `<input value=${token} name='card_token' type="hidden">`;   //paramsの中にトークンを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加

        // トークン情報生成のために使ったname属性を消す。
        document.getElementById("number").removeAttribute("name");
        document.getElementById("cvc").removeAttribute("name");
        document.getElementById("exp_month").removeAttribute("name");
        document.getElementById("exp_year").removeAttribute("name");

        document.getElementById("charge-form").submit();
      }
    });
  });
};
window.addEventListener('load', pay);