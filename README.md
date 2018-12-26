# KTX
Модуль для удобной работы с консолью<br/>
Содержит методы для создания псевдоокон и последовательности открытий "окон" внутри консоли<br/>
С помощью этого модуля можно запросто создать интерфейс для игры или софтовой программы.

## Использование
<ingore>0) </ignore>Для работы необходима среда PascalABC.NET последней версии<br/>
<ingore>1) </ignore>Скопируйте .pas файл в директорию с вашей программой и скомпилируйте его.<br/>
<ingore>2) </ignore>В начале программы введите <code>uses KTX;</code><br/>

Для полноценной работы необходима Windows XP и старше,
на Windows 10 требуется включить опцию консоли "Использовать прежнюю версию консоли".
Без этой опции работать будет далеко не всё (Особенно это касается изменения размера окна).

## Использование блоков KTX.Block
Простейшая программа, выводящая меню будущей игры:<br/>
```
uses KTX;

begin
  var menu := new KTX.Block;
  while menu do
  begin
    menu.Reload;
    
    Console.DrawOn(1,1,'(1) Новая игра');
    Console.DrawOn(1,2,'(2) Продолжить игру');
    Console.DrawOn(1,3,'(3) Настройки');
    Console.DrawOn(1,4,'(0) Выход');
    
    menu.Read;
    
    if menu.Input = '0' then menu.Close;
  end;
end.
```

## Использование вывода KTX.Drawing и файлов .ktx
Что бы конвертировать картинку в DrawBoxBlock (который является аргументом для вывода в процедурах Drawing.DrawAll, Drawing.HexDraw и т.д.), для начала необходимо создать картинку. Давайте возьмём следующую, размером 100x30 (стандартный размер консоли KTX):<br/>

![image.png](https://user-images.githubusercontent.com/44296606/50459244-81367280-097a-11e9-887f-65d4719c8131.png)
<br/>
Для того, что бы вывести её в консоль, необходимо написать следующий код:<br/>
```
uses KTX;

begin
  var a := KTX.Drawing.BitMapToDrawBoxBlock('image.png');
  Console.SetWindowSize(a.SizeX,a.SizeY);//Желательно, но можно обойтись и без этого
  KTX.Drawing.HexDraw(a);
  readln;
end.
```
И на выходе мы получим следующее:<br/>
![npp6](https://user-images.githubusercontent.com/44296606/50459349-4b45be00-097b-11e9-9f01-26d19a07ead9.png)

Что бы сохранить эту "картинку" в .ktx, нужно написать `a.WriteKTXFile('a.ktx');`<br/>
Что бы загрузить её из файла .ktx, нужно написать `var b := new KTX.DrawBoxBlock('a.ktx');`


## Лицензия
Вы можете встраивать этот .pcu-модуль в свои программы, с указанием где-либо в ней следующего:<br/>
<b>1) Моего имени: </b> Александр Котов</br>
<b>2) Ссылки на мой VK: </b> vk.com/id219453333</br>
<b>3) Названия группы VK: </b> Kotov Projects</br>
<b>4) Ссылки на группу: </b> vk.com/club158319378 <b> или </b> vk.com/ktvprj<br/>
<b>5) Ссылки на этот репозиторий: </b> github.com/AIexandrKotov/KTX</br></br>
Если по каким-то причинам перестанет существовать группа и моя страничка в VK, то будет достаточно имени и названия группы.<br/>
Также я могу дать вам разрешение писать просто `KTX by Alexandr Kotov`

Вы можете изменять этот файл, модифицируя его, но оговаривайте это в описании<br/>
Например: `KTX 2.0 , Mod by XXX` , где XXX - ваш псевдоним/имя/ник и т.д.<br/><br/>
Распространять <b>оригинал</b> можно только с моего разрешения<br/>
Распространять <b>свои модификации</b> при соблюдении правил можно без оного
