{$apptype console}
{$reference 'System.Drawing.dll'}

///Модуль для удобной работы с консолью
unit KTX;

uses System.Drawing;

const
  ///Название модуля
  Name = 'KTX Console Manager';
  ///Версия модуля
  Version: record Major, Minor, Build: integer; end = (Major: 2; Minor: 0; Build: 2);

///Возвращает строковое представление о текущей версии модуля
function StrVersion := $'{version.Major}.{version.Minor}.{version.Build}';

///Возвращает полное имя с версией
function StrFull := $'{Name} {StrVersion}';

///Возвращает true, если данный байт находится в диапазоне от а до b
function InRange(self: byte; a, b: byte): boolean; extensionmethod;
begin
  Result := (self >= a) and (self <= b);
end;

type
  
  ///Тип цвета консоли
  Color = System.ConsoleColor;

const
  ///Чёрный
  Black = Color.Black;
  ///Тёмно-синий
  DarkBlue = Color.DarkBlue;
  ///Тёмно-зелёный
  DarkGreen = Color.DarkGreen;
  ///Тёмно-бирюзовый
  DarkCyan = Color.DarkCyan;
  ///Тёмно-красный
  DarkRed = Color.DarkRed;
  ///Тёмно-пурпурный
  DarkMagenta = Color.DarkMagenta;
  ///Тёмно-жёлтый
  DarkYellow = Color.DarkYellow;
  ///Серый
  Gray = Color.Gray;
  ///Тёмно-серый
  DarkGray = Color.DarkGray;
  ///Синий
  Blue = Color.Blue;
  ///Зелёный
  Green = Color.Green;
  ///Бирюзовый
  Cyan = Color.Cyan;
  ///Красный
  Red = Color.Red;
  ///Пурпурный
  Magenta = Color.Magenta;
  ///Жёлтый
  Yellow = Color.Yellow;
  ///Белый
  White = Color.White;
  
type

  ///Класс, содержащий методы для работы с консолью
  Console = static class
    private const Err1: string = 'Window size too small';
    
    ///Изменяет название окна консоли
    public static procedure SetTitle(s: string);
    begin
      System.Console.Title:=s;
    end;
    
    ///Название консольного окна
    public static property Title: string read System.Console.Title write SetTitle;
    
    ///Включает видимость курсора
    internal static procedure Pre;
    begin
      System.Console.CursorVisible:=true;
    end;
    
    ///Отключает видимость курсора
    internal static procedure After;
    begin
      System.Console.CursorVisible:=false;
    end;
    
    private static IsInit: boolean;
    
    private static _MinimalWidth: integer = 100;
    private static _MinimalHeight: integer = 30;
    
    ///Минимально-допустимое значение ширины экрана
    public static property MinimalWidth: integer read _MinimalWidth;
    ///Минимально-допустимое значение высоты экрана
    public static property MinimalHeight: integer read _MinimalHeight;
    
    ///Задаёт минимально-допустимые значения ширины и высоты экрана
    public static procedure SetMinimal(x, y: integer);
    begin
      _MinimalWidth:=x;
      _MinimalHeight:=y;
    end;
    
    private static _width: integer = 100;
    private static _height: integer = 30;
    
    private static _cfore: Color = Black;
    private static _cback: Color = White;
    private static _cdisable: Color = Gray;
    private static _cerr: Color = Red;
    private static _ctrue: Color = DarkGreen;
    private static _cfalse: Color = Red;
    
    ///Задаёт действительное значение цвета фона
    public static procedure SetRealBackColor(a: Color);
    begin
      System.Console.BackgroundColor := a;
    end;
    
    ///Задаёт действительное значение цвета текста
    public static procedure SetRealForeColor(a: Color);
    begin
      System.Console.ForegroundColor := a;
    end;
    
    ///Задаёт или возвращает действительное значение цвета фона консоли
    public static property RealBack: Color read System.Console.BackgroundColor write SetRealBackColor;
    ///Задаёт или возвращает действительное значение цвета текста консоли
    public static property RealFore: Color read System.Console.ForegroundColor write SetRealForeColor;
    
    ///Стандартное значение цвета текста консоли
    public static property ColorFore: Color read _cfore;
    ///Стандартное значение цвета бэкграунда консоли
    public static property ColorBack: Color read _cback;
    ///Стандартное значение цвета недоступного текста консоли
    public static property ColorDisable: Color read _cdisable;
    ///Стандартное значение цвета текста ошибок консоли
    public static property ColorError: Color read _cerr;
    ///Стандартное значение цвета текста истинных значений консоли
    public static property ColorTrue: Color read _ctrue;
    ///Стандартное значение цвета текста ложных значений консоли
    public static property ColorFalse: Color read _cfalse;
    
    ///Действительная высота окна консоли
    public static property RealHeight: integer read System.Console.WindowHeight;
    ///Действительная ширина окна консоли
    public static property RealWidth: integer read System.Console.WindowWidth;
    
    ///Высота окна консоли
    public static property Height: integer read _height;
    ///Ширина окна консоли
    public static property Width: integer read _width;
    
    ///Максимально-возможная высота окна консоли
    public static property MaxHeight: integer read System.Console.LargestWindowHeight;
    
    ///Максимально-возможная ширина окна консоли
    public static property MaxWidth: integer read System.Console.LargestWindowWidth;
    
    ///Устанавливает положение курсора
    public static procedure SetCursorPosition(x, y: integer) := System.Console.SetCursorPosition(x,y);
    
    ///Устанавливает положение курсора
    public static procedure SetPos(x, y: integer) := System.Console.SetCursorPosition(x, y);
    
    ///Очищает окно консоли, заливая его текущем цветом бэкграунда
    public static procedure Clear() := System.Console.Clear();
    
    ///Задаёт размеры окна консоли текущими значениями ширины и высоты окна
    public static procedure SetWindowSize() := System.Console.SetWindowSize(_width, _height);
    
    ///Задаёт размеры окна консоли
    public static procedure SetWindowSize(x, y: integer);
    begin
      _width:=x;
      _height:=y;
      System.Console.SetWindowSize(x, y);
    end;
    
    ///Задаёт размер буфера консоли
    public static procedure SetBufferSize(x, y: integer) := System.Console.SetBufferSize(x, y);
    
    ///Задаёт размер буфера консоли
    public static procedure SetBufferSize(y: integer) := System.Console.SetBufferSize(_width,y);
    
    ///Изменяет цвет текста на цвет текста ошибок
    public static procedure SetFontError();
    begin
      System.Console.ForegroundColor:=_cerr;
    end;
    ///Изменяет цвет текста на цвет недоступного текста
    public static procedure SetFontOff();
    begin
      System.Console.ForegroundColor:=_cdisable;
    end;
    ///Изменяет цвет текста на стандартный
    public static procedure SetFontStandard();
    begin
      System.Console.ForegroundColor:=_cfore;
    end;
    ///Изменяет цвет текста на цвет ложного текста
    public static procedure SetFontFalse();
    begin
      System.Console.ForegroundColor:=_cfalse;
    end;
    ///Изменяет цвет текста на цвет истинного текста
    public static procedure SetFontTrue();
    begin
      System.Console.ForegroundColor:=_ctrue;
    end;
    ///Изменяет цвет текста на цвет текста по a
    public static procedure SetFontBool(a: boolean);
    begin
      if a then SetFontTrue() else SetFontFalse();
    end;
    
    ///Обновляет размеры консоли
    ///Рекомендуется использовать на каждой итерации цикла
    public static procedure Resize();
    begin
      while (Console.MaxWidth<Console.MinimalWidth) or (Console.MaxHeight<Console.MinimalHeight) do
      begin
        Clear();
        SetFontError();
        write(Err1);
        sleep(100);
        SetFontStandard();
      end;
      
      if not ((Console.Width<=Console.MaxWidth) and (Console.Height<=Console.MaxHeight)) then
      begin
        _width:=Console.MaxWidth;
        _height:=Console.MaxHeight;
        SetWindowSize();
      end;
      
      Clear();
      
      if (Console.RealHeight>console.Height) or (Console.RealWidth>console.Width) then System.Console.SetWindowSize(1,1);
      Console.SetBufferSize(Width,Height);
      Console.SetWindowSize(Width,Height);
    end;
    
    ///Изменяет размер буфера исходя из start и size
    public static procedure Resize(start, size: integer);
    begin
      if size>=(_Height-start) then Console.SetBufferSize(size+start);
    end;
    
    ///Инициализирует стандартные значения
    public static procedure Init;
    begin
      System.Console.BackgroundColor:=_cback;
      System.Console.ForegroundColor:=_cfore;
      System.Console.SetWindowSize(1,1);
      System.Console.SetBufferSize(_width, _height);
      System.Console.SetWindowSize(_width, _height);
      IsInit:=true;
    end;
    
    ///Выводит на экран текст
    ///Если в качестве аргумента использован цвет консоли, то меняет цвет текста на этот цвет-аргумент
    public static procedure Draw(params o: array of object);
    begin
      for var i:=0 to o.Length-1 do
      begin
        match o[i] with
          Color(var c): System.Console.ForegroundColor:=c;
          else write(o[i].ToString);
        end;
      end;
    end;
    
    ///Выводит на экран текст и переходит на новую строку
    ///Если в качестве аргумента использован цвет консоли, то меняет цвет текста на этот цвет-аргумент
    public static procedure DrawLn(params o: array of object);
    begin
      Draw(o,NewLine);
    end;
    
    ///Выводит на экран текст в позиции x, y
    ///Если в качестве аргумента использован цвет консоли, то меняет цвет текста на этот цвет-аргумент
    public static procedure DrawOn(x, y: integer; params o: array of object);
    begin
      Console.SetCursorPosition(x,y);
      Draw(o);
    end;
    
    ///Выводит на экран текст в позиции x, y и переходит на новую строку
    ///Если в качестве аргумента использован цвет консоли, то меняет цвет текста на этот цвет-аргумент
    public static procedure DrawLnOn(x, y: integer; params o: array of object);
    begin
      Console.SetCursorPosition(x,y);
      DrawLn(o);
    end;
  end;
  
  ///Представляет класс псевдоокна
  Block = class
    ///--
    private const Zero: integer = integer.MinValue;
    ///--
    private const Null: string = '';
  
    ///--
    private _input: string;
    ///--
    private _output: integer;
    ///--
    private _status: boolean;
    
    ///Изменяет вывод
    public procedure SetOut(a: integer);
    begin
      _output:=a;
    end;
    
    ///Ввод
    public property Input: string read _input;
    ///Вывод
    public property Output: integer read _output write SetOut;
    ///Состояние
    public property Status: boolean read _status;
    
    ///--
    public static function operator implicit(a: Block): boolean := a._status;
    
    ///Переводит Status в false
    public procedure Close();
    begin
      _status:=false;
    end;
    
    ///Создаёт новый экземпляр класса KTX.Block
    public constructor Create();
    begin
      if not Console.IsInit then Console.Init;
      _input:=Null;
      _output:=Zero;
      _status:=true;
    end;
    
    ///Обнуляет ввод и вывод
    public procedure Reload();
    begin
      Console.Resize;
      _input:=Null;
      _output:=Zero;
    end;
    
    ///Ввод
    public procedure Read();
    begin
      Console.Pre;
      var s: string = '';
      while (s='') and ((Console.RealHeight=Console.Height) and (Console.RealWidth=Console.Width)) do
      begin
        Console.SetCursorPosition(1,Console.Height-2);write(': ');
        readln(s);
      end;
      _input:=s;
      Console.After;
    end;
    
    ///Ввод при изменении размера
    public procedure ReadWithResize(start, size: integer);
    begin
      Console.Pre;
      var s: string = '';
      while (s='') and ((Console.RealHeight=Console.Height) and (Console.RealWidth=Console.Width)) do
      begin
        if size>=(Console.Height-start) then
        begin
          Console.SetCursorPosition(1,size+start-1);
          Console.SetCursorPosition(1,size+start-2);
        end
        else Console.SetCursorPosition(1,Console.Height-2);
        write(': ');
        readln(s);
      end;
      _input:=s;
      Console.After;
    end;
    
    ///Возвращает Input текущего псевдоокна
    public function ToString: string; override := _input;
  end;
  
  ///Класс, содержащий методы преобразования цвета консоли в целые десятичные и шестнадцатиричные числа и обратно
  ConvertColor = static class
    ///Переводит цвет консоли в целое число (byte)
    public static function ColorToInt(a: Color): byte := Ord(a);
    ///Переводит целое число (byte) в цвет консоли
    public static function IntToColor(a: byte): Color := Color(integer(a));
    ///Переводит цвет консоли в шестнадцатиричное число
    public static function ColorToHex(a: Color): char := ColorToInt(a).ToString('X')[1];
    ///Переводит шестнадцатиричное число в цвет консоли
    public static function HexToColor(s: char): Color := IntToColor(System.Convert.ToInt32(s,16));
  end;
  
  ///Представляет клетку консоли
  DrawBox = class
    ///Положение клетки по X (ширине)
    public PosX: integer;
    ///Положение клетки по Y (высоте)
    public PosY: integer;
    ///Цвет BackgroundColor клетки
    public Back: Color;
    ///Цвет ForegroundColor клетки
    public Fore: Color;
    ///Символ, находящийся в клетке
    public Symbol: char;
    
    ///Создаёт новый экземпляр класса DrawBox
    public constructor (x,y: integer; c: char; B, F: Color);
    begin
      PosX:=x;
      PosY:=y;
      Back:=B;
      Fore:=F;
      Symbol:=c;
    end;
    
    //public static function Parse(s: string): DrawBox := new DrawBox(s);
    
    ///Возвращает строковое представление текущего экземпляра класса
    public function ToString: string; override;
    begin
      Result := $'({PosX},{PosY},{Back},{Fore},{Symbol})';
    end;
  end;
  
  //Структура клетки для записи в файл или чтения из файла
  ///--
  DrawBoxFile = record
    x, y: integer;
    c: char;
    b, f: byte;
    
    ///Создаёт новую запись DrawBoxFile
    public constructor;
    begin end;
    
    ///Создаёт новую запись DrawBoxFile из экземпляра класса DrawBox
    public constructor (a: DrawBox);
    begin
      x:=a.PosX;
      y:=a.PosY;
      c:=a.Symbol;
      b:=ConvertColor.ColorToInt(a.Back);
      f:=ConvertColor.ColorToInt(a.Fore);
    end;
    
    ///Возвращает экземпляр класса DrawBox, созданный из текущей записи DrawBoxFile
    public function ToDrawBox: DrawBox;
    begin
      Result:=new DrawBox(x,y,c,ConvertColor.IntToColor(b),ConvertColor.IntToColor(f));
    end;
  end;
  
  ///Преставляет окно, в котором проводится рисование
  DrawBoxBlock = class
    ///Ширина окна рисования
    public SizeX: integer;
    ///Высота окна рисования
    public SizeY: integer;
    ///Основной цвет окна
    public Background: Color;
    ///Массив клеток консоли
    public Draws: array of DrawBox;
    
    ///Создаёт новый экземпляр клссса DrawBoxBlock
    public constructor (x, y: integer; b: Color; arr: array of DrawBox);
    begin
      SizeX:=x;
      SizeY:=y;
      Background:=b;
      Draws:=arr;
    end;
    
    ///Создаёт новый экземпляр клссса DrawBoxBlock, загружая его из файла name
    public constructor (name: string);
    begin
      var f: file;
      reset(f,name);
      Read(f,SizeX);
      Read(f,SizeY);
      var a1: byte;
      var a2: integer;
      Read(f,a1);
      Read(f,a2);
      Background:=ConvertColor.IntToColor(a1);
      Draws:=new DrawBox[a2];
      for var i:=0 to Draws.Length-1 do
      begin
        var a3: DrawBoxFile;
        Read(f,a3);
        Draws[i]:=a3.ToDrawBox;
      end;
      f.Close;
    end;
    
    ///Сохраняет текущий экземпляр класса DrawBoxBlock в файл name
    public procedure WriteKTXFile(name: string);
    begin
      var f: file;
      rewrite(f,name);
      f.Write(SizeX);
      f.Write(SizeY);
      f.Write(ConvertColor.ColorToInt(Background));
      f.Write(Draws.Length);
      for var i:=0 to Draws.Length-1 do
      begin
        f.Write(new DrawBoxFile(Draws[i]));
      end;
      f.Close;
    end;
  end;
  
  ///Содержит методы для рисования
  Drawing = static class
    public static function RGBToColor(r, g, b: byte): KTX.Color;
    begin
      if (r.InRange(0,64)) and (g.InRange(0,64)) and (b.InRange(0,64)) then Result:=KTX.Black;
      if (r.InRange(0,64)) and (g.InRange(65,159)) and (b.InRange(65,159)) then Result:=KTX.DarkGray;
      if (r.InRange(160,223)) and (g.InRange(160,223)) and (b.InRange(160,223)) then Result:=KTX.Gray;
      if (r.InRange(224,255)) and (g.InRange(224,255)) and (b.InRange(224,255)) then Result:=KTX.White;
      
      if (r.InRange(65,191)) and (g.InRange(0,64)) and (b.InRange(0,64)) then Result:=KTX.DarkRed;
      if (r.InRange(0,64)) and (g.InRange(65,191)) and (b.InRange(0,64)) then Result:=KTX.DarkGreen;
      if (r.InRange(0,64)) and (g.InRange(0,64)) and (b.InRange(65,191)) then Result:=KTX.DarkBlue;
      
      if (r.InRange(0,64)) and (g.InRange(65,191)) and (b.InRange(65,191)) then Result:=KTX.DarkCyan;
      if (r.InRange(65,191)) and (g.InRange(0,64)) and (b.InRange(65,191)) then Result:=KTX.DarkMagenta;
      if (r.InRange(65,191)) and (g.InRange(65,191)) and (b.InRange(0,64)) then Result:=KTX.DarkYellow;
      
      if (r.InRange(192,255)) and (g.InRange(0,64)) and (b.InRange(0,64)) then Result:=KTX.Red;
      if (r.InRange(0,64)) and (g.InRange(192,255)) and (b.InRange(0,64)) then Result:=KTX.Green;
      if (r.InRange(0,64)) and (g.InRange(0,64)) and (b.InRange(192,255)) then Result:=KTX.Blue;
      
      if (r.InRange(0,64)) and (g.InRange(192,255)) and (b.InRange(192,255)) then Result:=KTX.Cyan;
      if (r.InRange(192,255)) and (g.InRange(0,64)) and (b.InRange(192,255)) then Result:=KTX.Magenta;
      if (r.InRange(192,255)) and (g.InRange(192,255)) and (b.InRange(0,64)) then Result:=KTX.Yellow;
    end;
    
    ///Преобразует ARGB (4 байтовое) представление цвета в DrawBox
    public static function ARGBPixelToDrawBox(x, y: integer; bg: Color; a, r, g, b: byte): DrawBox;
    const
      //░▒▓█
      Context = ' .:;t08SX%&#@';
    begin
      Result := new DrawBox();
      
      Result.PosX := x;
      Result.PosY := y;
      Result.Symbol:=' ';
      Result.Back:=RGBToColor(r,g,b);
      
      case bg of //ToDo this
        Color.White: if (r = 255) and (g = 255) and (b = 255) then Result.Symbol := 'T';
        Color.Black: if (r = 0) and (g = 0) and (b = 0) then Result.Symbol := 'T';
      end;
      
    end;
    
    ///Преобразует файл-рисунок в экземпляр класса DrawBoxBlock
    public static function BitMapToDrawBoxBlock(bmpname: string): DrawBoxBlock;
    begin
      var b := new Bitmap(bmpname);
      
      Result := new DrawBoxBlock();
      Result.SizeX := b.Width;
      Result.SizeY := b.Height;
      
      var Draws := new List<DrawBox>;
      var Colors := new List<System.Drawing.Color>;
      
      for var i:=0 to (b.Width)*(b.Height) - 2 do
      begin
        var xx := i mod b.Width;
        var yy := i div b.Width;
        Colors += b.GetPixel(xx,yy);
      end;
      
      var bgrnd0 := System.Drawing.Color.FromArgb(Colors.GroupBy(x -> x.ToArgb).MaxBy(x -> x.Count).Key);
      var bgrnd := RGBToColor(bgrnd0.A, bgrnd0.G, bgrnd0.B);
      Result.Background := bgrnd;
      
      for var i:=0 to (b.Width)*(b.Height) - 2 do
      begin
        var xx := i mod b.Width;
        var yy := i div b.Width;
        var cc := b.GetPixel(xx,yy);
        
        Draws+=ARGBPixelToDrawBox(xx,yy, bgrnd, cc.A, cc.R, cc.G, cc.B);
      end;
      
      Draws.RemoveAll(x -> (x = nil) or (x.Symbol = 'T'));
      Result.Draws := Draws.ToArray;
    end;
    
    ///Преобразует файл-рисунок bmpname в файл .ktx
    public static procedure BitMapToKTXFile(bmpname, ktxname: string);
    begin
      BitMapToDrawBoxBlock(bmpname).WriteKTXFile(ktxname);
    end;
    
    ///Возвращает левый верхний угол окна рисования
    public static function GetStartPos(a: DrawBoxBlock): (integer, integer);
    begin
      var x:=abs(a.SizeX-Console.Width) div 2;
      var y:=abs(a.SizeY-Console.Height) div 2;
      Result:=(x,y);
    end;
    
    ///Полный вывод всей картинки
    public static procedure DrawAll(a: DrawBoxBlock);
    begin
      var t:=GetStartPos(a);
      var (x, y):=t;
      System.Console.BackgroundColor:=a.Background;
      Console.Clear;
      for var i:=0 to a.Draws.Length-1 do
      begin
        Console.SetCursorPosition(a.Draws[i].PosX+x,a.Draws[i].PosY+y);
        System.Console.BackgroundColor:=a.Draws[i].Back;
        System.Console.ForegroundColor:=a.Draws[i].Fore;
        write(a.Draws[i].Symbol);
      end;
    end;
    
    ///Быстрый вывод по цветам заднего фона консоли
    public static procedure HexDraw(a: DrawBoxBlock);
    begin
      var t:=GetStartPos(a);
      var (x, y):=t;
      System.Console.BackgroundColor:=a.Background;
      Console.Clear;
      var aa: array[1..16] of array of DrawBox;
      for var i:=1 to 16 do
      begin
        aa[i]:=a.Draws.Where(x -> ConvertColor.ColorToInt(x.Back)=i-1).ToArray;
      end;
      for var i:=1 to 16 do
      begin
        System.Console.BackgroundColor:=ConvertColor.IntToColor(i-1);
        if aa[i]<>nil then
        begin
          for var j:=0 to aa[i].Length-1 do
          begin
            Console.SetCursorPosition(aa[i][j].PosX+x,aa[i][j].PosY+y);
            System.Console.ForegroundColor:=aa[i][j].Fore;
            write(aa[i][j].Symbol);
          end;
        end;
      end;
    end;
    
    ///Быстрый вывод по цветам заднего фона консоли
    ///Медленнее обычного HexDraw, но окажется гораздо быстрее, если в DrawBox'ах используется один и тот же цвет текста
    public static procedure HexDrawWithSearch(a: DrawBoxBlock);
    begin
      var t:=GetStartPos(a);
      var (x, y):=t;
      System.Console.BackgroundColor:=a.Background;
      Console.Clear;
      var aa: array[1..16] of array of DrawBox;
      for var i:=1 to 16 do
      begin
        aa[i]:=a.Draws.Where(x -> ConvertColor.ColorToInt(x.Back)=i-1).ToArray;
      end;
      for var i:=1 to 16 do
      begin
        System.Console.BackgroundColor:=ConvertColor.IntToColor(i-1);
        if aa[i]<>nil then
        begin
          for var j:=0 to aa[i].Length-1 do
          begin
            Console.SetCursorPosition(aa[i][j].PosX+x,aa[i][j].PosY+y);
            if Console.RealFore<>aa[i][j].Fore then System.Console.ForegroundColor:=aa[i][j].Fore;
            write(aa[i][j].Symbol);
          end;
        end;
      end;
    end;
  end;

begin
  
end.