# KTX
Модуль для удобной работы с консолью<br/>
Содержит методы для создания псевдоокон и последовательности открытий "окон" внутри консоли<br/>
С помощью этого модуля можно запросто создать интерфейс для игры или софтовой программы<br/>
Кроме всего прочего, содержит и другие полезные средства.<br/><br/>
<b>Содержание:</b><br/>
1\. Установка в директорию PascalABC.NET<br/>
2\. Использование без установки в директорию<br/>
3\. Блоки KTX.Block<br/>
4\. Блоки KTX.KeyBlock<br/>
5\. Класс KTX.Drawing и его использование<br/>
6\. Методы KTX.Console<br/>

## 1. Установка в директорию PascalABC.NET
<ingore>1) </ignore>Для работы необходима среда PascalABC.NET последней версии<br/>
<ingore>2) </ignore>Скопируйте .pas файл в папку LibSource директории PascalABC.NET<br/>
<ingore>3) </ignore>Скопируйте .pcu файл в папку Lib директории PascalABC.NET<br/>
<ingore>4) </ignore>Если нужно использовать модуль, напишите в начале программы <code>uses KTX;</code><br/>

Для полноценной работы необходима Windows XP и старше, на Windows 10 требуется включить опцию консоли "Использовать прежнюю версию консоли".
Без этой опции работать будет далеко не всё (Особенно это касается изменения размера окна).

## 2. Использование без установки в директорию
<ingore>1) </ignore>Для работы необходима среда PascalABC.NET последней версии<br/>
<ingore>2) </ignore>Скопируйте .pas и .pcu файлы в папку с вашей программой<br/>
<ingore>3) </ignore>Напишите в начале программы <code>uses KTX;</code><br/>

## 3. Блоки KTX.Block
Любой блок задаётся следующим образом:<br/>
```pas
var b := new KTX.Block;
```
У блока есть три основных свойства:<br/><br/>
<b>Status</b> — показатель, который влияет на продолжение цикла по текущему блоку, после создания имеет значение true, зачение false выставляется методом <code>.Close</code><br/><br/>
<b>Input</b> — строка, введённая пользователем в консоль, заполняется с помощью <code>.Read</code>, обнуляется с помощью <code>.Reload</code><br/><br/>
<b>Output</b> — целое число, ни на что не влияет, просто дополнительная переменная. Обнуляется до <code>integer.MinValue</code> в <code>.Reload</code> каждую итерацию цикла. Обычно используется как индекс массива при выводе списков.<br/><br/>
И одно дополнительное:<br/><br/>
<b>OutIsDigit</b> — возвращает true, если Input является целым числом. Внутри себя единожды на итерацию проводит вычисление Output, которое получает числовое представление Input, из-за чего очень удобно использовать конструкцию <code>if (b.OutIsDigit) and (b.Output > 100) then</code>

Что бы использовать блок, нужно начать цикл, в котором в качестве условия будет указано название блока. Рекомендется использовать цикл <b>while</b>. Типичный блок выглядит так:
```pas
uses KTX;

begin
  var b := new KTX.Block;
  while b do
  begin
    b.Reload;
    
    //Интерфейс блока
    
    b.Read;
    
    //Условия переходов между блоками
  end;
end.
```
<code>b.Reload</code> всегда должно быть перед всем остальным, так как оно очищает консоль<br/>
Самым первым условием обычно прописывается выход из блока: <code>if b.Input='0' then b.Close;</code><br/><br/>
Простейшая программа, выводящая меню будущей игры:<br/>
```pas
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
![npp7](https://user-images.githubusercontent.com/44296606/50459403-d0c96e00-097b-11e9-90f4-25a40257a489.png)

Для вывода списков используются методы <code>Console.Resize(<начальная позиция списка>, <размер списка>)</code> и <code>b.ReadWithResize(<начальная позиция списка>, <размер списка>)</code>

Следующий код реализует список из 50-ти элементов, в каждый из которых можно "заглянуть".
```pas
uses KTX;

begin
  var b := new KTX.Block;
  while b do
  begin
    b.Reload;
    
    var first := 1;
    var count := 50;
      
    Console.Resize(first, count);
    
    for var i:=0 to count-1 do
      Console.DrawOn(1, first+i, $'({i+1}) ...');
    
    b.ReadWithResize(first, count);
    
    if b.Input = '0' then b.Close;
    
    if (b.OutIsDigit) and (b.Output > 0) and (b.Output <= count) then
    begin
      var bb := new KTX.Block;
      while bb do
      begin
        bb.Reload;
        
        Console.DrawOn(1, 1, $'Элемент списка #{b.Output}');
        
        bb.Read;
        
        if bb.Input = '0' then bb.Close;
      end;
    end;
  end;
end.
```

## 4. Блоки KTX.KeyBlock
KeyBlock'и нужны для системы последовательного открывания блоков, как в KTX.Block, но с главным отличием — в качестве ввода используется не строки, введённые с клавиатуры, а сами клавиши клавиатуры.
Простейший KeyBlock задаётся одной строкой:
```pas
  var a := new KTX.KeyBlock(() -> StandardKeyBlocksBuilders.BuildCleanKeyBlock.ToKeyBlock);
```
Что бы создать любой KeyBlock используются строители этого типа — KeyBlockBuilder'ы.<br/>
Задаются они легко:<br/>
```pas
  var b := new KTX.KeyBlockBuilder;
```
Что бы выделить KeyBlock из строителя используется фукнция .ToKeyBlock <code>b.ToKeyBlock</code><br/>
Но рекомендуется описывать строителя в лямбде конструктора KeyBlock'а.<br/>
Как, например, в этом случае:<br/>
```pas
uses KTX;

begin
  var b := new KTX.KeyBlock(() ->
  begin
    var k := new KTX.KeyBlockBuilder;
    k.AddStage(1,100,1);
    k.StandardStage := 0;
    k.CheckStages := true;
    k.AddExiter(Key.Escape);
    k.AddConfirmer(Key.Enter);
    k.AddIncreasers(Key.DownArrow, Key.S);
    k.AddDecreasers(Key.UpArrow, Key.W);
    Result := k.ToKeyBlock;
  end);
  while b do
  begin
    b.Reload;
    
    Console.DrawOn(1,1,b.Stage[0]);
    
    b.Read;
    
    if b.Confirm then b.CurrentStage+=20;
  end;
end.
```
В этом примере стрелками вы сможете изменить значение числа (позиции) на 1, нажав Enter — увеличить на 20. Escape закроет текущий блок.<br/>
Если вы хотите задать собственные зависимости клавиш внутри блока, можете просто выключить стандартную проверку позиций <code>k.CheckStages := false;</code>, а также не заполнять Exiters (клавиши выхода) и Confirmers.
<code>Этот раздел разрабатывается</code>

## 5. Класс KTX.Drawing и его использование
На что способен KTX.Drawing (new-конвертация, теперь уже старая):<br/>
![4](https://user-images.githubusercontent.com/44296606/52221089-7643fb80-28b1-11e9-9e5c-00935eead4d7.png)<br/>
На что он способен сейчас:
![image](https://user-images.githubusercontent.com/44296606/84887665-c5519180-b09e-11ea-8ac2-584b8938ac36.png)<br/>


<code>Этот раздел разрабатывается</code>

## 6. Методы KTX.Console
<code>Этот раздел разрабатывается</code>

## Лицензия
Вы можете встраивать этот .pcu-модуль в свои программы без указания меня как автора, но обязательно указать где-либо <code>Made with KTX.StrFull</code> или <code>Используется KTX.StrFull</code><br/><br/>
Если же всё-таки вы желаете указать меня как автора, то достаточно указать ссылку на этот репозиторий, указать где-либо <code>KTX by Alexandr Kotov</code> или оставить ссылку на [мою страничку ВКонтакте](https://vk.com/id219453333)<br/><br/>
Изменять, модифицировать и распостранять можно.
