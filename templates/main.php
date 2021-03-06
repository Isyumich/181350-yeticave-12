<?php

function setPriceFormat($number) {
    $ceilNumber = ceil($number);
    if($ceilNumber < 1000) {
        return $ceilNumber . ' ₽';
    } else {
        return number_format($ceilNumber, 0, '.', ' ') . ' ₽';
    }
}
function getExpiryTime($date) {
    $curDate = date_create("now");
    $endDate = date_create($date);
    $diffDate = date_diff($curDate, $endDate);
    $countHours = $diffDate->h + $diffDate->d * 24;
    $countMinutes = $diffDate->i;
    return [$countHours, $countMinutes];
}
?>

    <main class="container">
        <section class="promo">
            <h2 class="promo__title">Нужен стафф для катки?</h2>
            <p class="promo__text">На нашем интернет-аукционе ты найдёшь самое эксклюзивное сноубордическое и горнолыжное снаряжение.</p>
            <ul class="promo__list">
                <?php foreach ($categories as $category):?>
                    <li class="promo__item promo__item--<?=$category['symbol_code']?>">
                        <a class="promo__link" href="../pages/all-lots.html"><?=$category['name']?></a>
                    </li>
                <?php endforeach;?>
            </ul>
        </section>
        <section class="lots">
            <div class="lots__header">
                <h2>Открытые лоты</h2>
            </div>
            <ul class="lots__list">
                <!--заполните этот список из массива с товарами-->
                <?php foreach ($lots as $lot):
                    $dateDiff = getExpiryTime($lot['end_date']);
                    $lotName = $lot['name'];
                    $sqlIdLot = "select id from lot where name = '$lotName'";
                    $idLot = mysqli_fetch_assoc(mysqli_query($con, $sqlIdLot));
                    ?>
                    <li class="lots__item lot">
                        <div class="lot__image">
                            <img src="<?= $lot['picture'] ?>" width="350" height="260" alt="">
                        </div>
                        <div class="lot__info">
                            <span class="lot__category"><?= $lot['category'] ?></span>
                            <h3 class="lot__title">
                                <a class="text-link" href="lot.php?id=<?= $idLot['id'] ?>"> <?= $lotName ?></a>
                            </h3>
                            <div class="lot__state">
                                <div class="lot__rate">
                                    <span class="lot__amount">Стартовая цена</span>
                                    <span class="lot__cost"><?= setPriceFormat($lot['start_price']) ?></span>
                                </div>
                                <div class="lot__timer timer <?php if($dateDiff[0] < 1):?>timer--finishing<?php endif;?>">
                                    <?= $dateDiff[0] . ':' . $dateDiff[1] ?>
                                </div>
                            </div>
                        </div>
                    </li>
                <?php endforeach;?>
            </ul>
        </section>
    </main>


