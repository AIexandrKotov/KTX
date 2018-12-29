{$apptype console}
{$reference 'System.Drawing.dll'}

///Модуль для удобной работы с консолью
unit KTX;

uses System.Drawing;

const
  ///Название модуля
  Name = 'KTX Console Manager';
  ///Версия модуля
  Version: record Major, Minor, Build: integer; end = (Major: 2; Minor: 0; Build: 17);

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
  
  ///Тип клавиши консоли
  Key = System.ConsoleKey;

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
  
  
  ///Представляет класс псевдоокна, который управляется клавишами
  KeyBlock = class
    private _status: boolean;
    private _stage: array of integer;
    private _output: System.ConsoleKeyInfo;
    
    ///Состояние блока
    public property Status: boolean read _status;
    
    ///Целочисленные параметры блока
    public property Stage: array of integer read _stage;
    
    ///Возвращает информацию о введённой клавише
    public property Input: System.ConsoleKeyInfo read _output;
    
    ///Чтение клавиши
    public procedure Read;
    begin
      _output := System.Console.ReadKey(true);
    end;
    
    ///Обновляет консоль
    public procedure Update;
    begin
      Console.Resize;
    end;
    
    ///Обновляет консоль
    public procedure Reload;
    begin
      Console.Resize;
    end;
    
    public procedure SetStage(id, value: integer) := _stage[id] := value;
    
    public procedure SetSize(length: integer) := SetLength(_stage,length);
    
    public procedure Close();
    begin
      _status := false;
    end;
    
    public constructor;
    begin
      if not Console.IsInit then Console.Init;
      _status := true;
      _stage := new integer[1];
      _stage[0] := 1;
    end;
    
    public constructor(a: integer);
    begin
      if not Console.IsInit then Console.Init;
      _status := true;
      _stage := new integer[a];
      for var i:=0 to _stage.Length-1 do _stage[i] := 1;
    end;
    
    ///--
    public static function operator implicit(a: KeyBlock): boolean := a._status;
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
  
  //Параметры консольного цвета
  ///--
  RGBColor = record
    ///Красный компонент данного цвета
    public R: byte;
    ///Зелёный компонент данного цвета
    public G: byte;
    ///Синий компонент данного цвета
    public B: byte;
    ///Консольный цвет данного цвета
    public ConsoleColor: Color;
    
    private constructor := exit;
    
    public constructor (r, g, b: byte; c: Color);
    begin
      Self.R := r;
      Self.G := g;
      Self.B := b;
      Self.ConsoleColor := c;
    end;
  end;
  
  ///Тип конвертации RGB в ConsoleColor
  RGBToColorConvertType = (old, &new);
  
  ///Класс, содержащий значения цветов консоли в виде RGB
  RGBConsole = static class
    private static _black := new RGBColor(0,0,0,Color.Black);
    private static _darkgray := new RGBColor(128,128,128,Color.DarkGray);
    private static _gray := new RGBColor(192,192,192,Color.Gray);
    private static _white := new RGBColor(255,255,255,Color.White);
    
    private static _darkblue := new RGBColor(0,0,128,Color.DarkBlue);
    private static _darkgreen := new RGBColor(0,128,0,Color.DarkGreen);
    private static _darkred := new RGBColor(128,0,0,Color.DarkRed);
    private static _darkcyan := new RGBColor(0,128,128,Color.DarkCyan);
    private static _darkyellow := new RGBColor(128,128,0,Color.DarkYellow);
    private static _darkmagenta := new RGBColor(128,0,128,Color.DarkMagenta);
    
    private static _blue := new RGBColor(0,0,255,Color.Blue);
    private static _green := new RGBColor(0,255,0,Color.Green);
    private static _red := new RGBColor(255,0,0,Color.Red);
    private static _cyan := new RGBColor(0,255,255,Color.Cyan);
    private static _yellow := new RGBColor(255,255,0,Color.Yellow);
    private static _magenta := new RGBColor(255,0,255,Color.Magenta);
    
    ///RGB Чёрного цвета консоли
    public static property Black: RGBColor read _black;
    ///RGB Тёмно-серого цвета консоли
    public static property DarkGray: RGBColor read _darkgray;
    ///RGB Серого цвета консоли
    public static property Gray: RGBColor read _gray;
    ///RGB Белого цвета консоли
    public static property White: RGBColor read _white;
    
    ///RGB Тёмно-синего цвета консоли
    public static property DarkBlue: RGBColor read _darkblue;
    ///RGB Тёмно-зелёного цвета консоли
    public static property DarkGreen: RGBColor read _darkgreen;
    ///RGB Тёмно-красного цвета консоли
    public static property DarkRed: RGBColor read _darkred;
    ///RGB Тёмно-бирюзового цвета консоли
    public static property DarkCyan: RGBColor read _darkcyan;
    ///RGB Тёмно-жёлтого цвета консоли
    public static property DarkYellow: RGBColor read _darkyellow;
    ///RGB Тёмно-фиолетового цвета консоли
    public static property DarkMagenta: RGBColor read _darkmagenta;
    
    ///RGB Синего цвета консоли
    public static property Blue: RGBColor read _blue;
    ///RGB Зелёного цвета консоли
    public static property Green: RGBColor read _green;
    ///RGB Красного цвета консоли
    public static property Red: RGBColor read _red;
    ///RGB Бирюзового цвета консоли
    public static property Cyan: RGBColor read _cyan;
    ///RGB Жёлтого цвета консоли
    public static property Yellow: RGBColor read _yellow;
    ///RGB Фиолетового цвета консоли
    public static property Magenta: RGBColor read _magenta;
    
    ///Новое преобразование
    public static function FromRGB(R, G, B: byte): Color;
    begin
      //Чёрный цвет
      if (R.InRange(0,63)) and (G.InRange(0,63)) and (B.InRange(0,63)) then Result := _black.ConsoleColor;
      
      //Тёмно-серый цвет
      if (R.InRange(96,159)) and (G.InRange(64,191)) and (B.InRange(64,191)) then Result := _darkgray.ConsoleColor;
      
      //Серый цвет
      if ((R.InRange(160,255)) and (G.InRange(64,191)) and (B.InRange(64,191)))
      or ((R.InRange(96,159)) and (G.InRange(128,255)) and (B.InRange(192,255)))
      or ((R.InRange(96,159)) and (G.InRange(192,255)) and (B.InRange(128,255))) then Result := _gray.ConsoleColor;
      
      //Белый цвет
      if ((R.InRange(160,255)) and (G.InRange(128,255)) and (B.InRange(192,255)))
      or ((R.InRange(160,255)) and (G.InRange(192,255)) and (B.InRange(128,255))) then Result := _white.ConsoleColor;
      
      //Тёмно-красный цвет
      if ((R.InRange(96,159)) and (G.InRange(0,63)) and (B.InRange(0,63)))
      or ((R.InRange(96,159)) and (G.InRange(64,127)) and (B.InRange(0,63)))
      or ((R.InRange(96,159)) and (G.InRange(0,63)) and (B.InRange(64,127))) then Result := _darkred.ConsoleColor;
      
      //Тёмно-зелёный цвет
      if ((R.InRange(0,95)) and (G.InRange(64,191)) and (B.InRange(0,63))) then Result := _darkgreen.ConsoleColor;
      
      //Тёмно-синий цвет
      if ((R.InRange(0,95)) and (G.InRange(0,63)) and (B.InRange(64,191))) then Result := _darkblue.ConsoleColor;
      
      //Тёмно-пурпурный цвет
      if ((R.InRange(96,159)) and (G.InRange(0,63)) and (B.InRange(128,255)))
      or ((R.InRange(96,159)) and (G.InRange(64,127)) and (B.InRange(192,255))) then Result := _darkmagenta.ConsoleColor;
      
      //Тёмно-жёлтый цвет
      if ((R.InRange(96,159)) and (G.InRange(127,255)) and (B.InRange(0,63)))
      or ((R.InRange(96,159)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _darkyellow.ConsoleColor;
      
      //Тёмно-голубой цвет
      if (R.InRange(0,95)) and (G.InRange(64,191)) and (B.InRange(64,191)) then Result := _darkcyan.ConsoleColor;
      
      //Красный цвет
      if ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(64,127)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(64,127))) then Result := _red.ConsoleColor;
      
      //Зелёный цвет
      if ((R.InRange(0,95)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _darkgreen.ConsoleColor;
      
      //Синий цвет
      if ((R.InRange(0,95)) and (G.InRange(0,127)) and (B.InRange(160,225))) then Result := _darkblue.ConsoleColor;
      
      //Пурпурный цвет
      if ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(128,255)))
      or ((R.InRange(160,255)) and (G.InRange(64,127)) and (B.InRange(192,255))) then Result := _darkmagenta.ConsoleColor;
      
      //Жёлтый цвет
      if ((R.InRange(160,255)) and (G.InRange(127,255)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _darkyellow.ConsoleColor;
      
      //Тёмно-голубой цвет
      if ((R.InRange(0,95)) and (G.InRange(128,255)) and (B.InRange(160,255)))
      or ((R.InRange(0,95)) and (G.InRange(160,255)) and (B.InRange(128,255))) then Result := _darkcyan.ConsoleColor;
    end;
    
    ///Преобразование версии 2.0.2
    public static function OldRGBToColor(r, g, b: byte): KTX.Color;
    begin
      if (r.InRange(0,63)) and (g.InRange(0,63)) and (b.InRange(0,63)) then Result:=KTX.Black;
      if (r.InRange(64,159)) and (g.InRange(64,159)) and (b.InRange(64,159)) then Result:=KTX.DarkGray;
      if (r.InRange(160,222)) and (g.InRange(160,222)) and (b.InRange(160,222)) then Result:=KTX.Gray;
      if (r.InRange(223,255)) and (g.InRange(223,255)) and (b.InRange(223,255)) then Result:=KTX.White;
      
      if (r.InRange(64,191)) and (g.InRange(0,63)) and (b.InRange(0,63)) then Result:=KTX.DarkRed;
      if (r.InRange(0,63)) and (g.InRange(64,191)) and (b.InRange(0,63)) then Result:=KTX.DarkGreen;
      if (r.InRange(0,63)) and (g.InRange(0,63)) and (b.InRange(64,191)) then Result:=KTX.DarkBlue;
      
      if (r.InRange(0,63)) and (g.InRange(64,191)) and (b.InRange(64,191)) then Result:=KTX.DarkCyan;
      if (r.InRange(64,191)) and (g.InRange(0,63)) and (b.InRange(64,191)) then Result:=KTX.DarkMagenta;
      if (r.InRange(64,191)) and (g.InRange(64,191)) and (b.InRange(0,63)) then Result:=KTX.DarkYellow;
      
      if (r.InRange(192,255)) and (g.InRange(0,63)) and (b.InRange(0,63)) then Result:=KTX.Red;
      if (r.InRange(0,63)) and (g.InRange(192,255)) and (b.InRange(0,63)) then Result:=KTX.Green;
      if (r.InRange(0,63)) and (g.InRange(0,63)) and (b.InRange(192,255)) then Result:=KTX.Blue;
      
      if (r.InRange(0,63)) and (g.InRange(192,255)) and (b.InRange(192,255)) then Result:=KTX.Cyan;
      if (r.InRange(192,255)) and (g.InRange(0,63)) and (b.InRange(192,255)) then Result:=KTX.Magenta;
      if (r.InRange(192,255)) and (g.InRange(192,255)) and (b.InRange(0,63)) then Result:=KTX.Yellow;
    end;
    
    ///Преобразует RGB в ConsoleColor
    public static function RGBToColor(a: RGBToColorConvertType; r, g, b: byte): Color;
    begin
      case a of
        old: Result := OldRGBToColor(r, g, b);
        &new: Result := FromRGB(r, g, b);
      end;
    end;
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
    public static RGBConvertingType: RGBToColorConvertType := RGBToColorConvertType.new;
    
    ///Преобразует ARGB (4 байтовое) представление цвета в DrawBox
    public static function ARGBPixelToDrawBox(x, y: integer; bg: Color; a, r, g, b: byte): DrawBox;
    const
      ///Длина обязательно 16
      Context = ' .:;t08SX%&#@░▒▓';
    begin
      Result := new DrawBox();
      
      Result.PosX := x;
      Result.PosY := y;
      Result.Symbol:=' ';
      Result.Back:=RGBConsole.RGBToColor(RGBConvertingType,r,g,b);
      
      var RR := (r mod 16) + 1;
      var GG := (g mod 16) + 1;
      var BB := (b mod 16) + 1;
      Result.Symbol := Context[Round(Arr(RR,GG,BB).Average)];
      Result.Fore := RGBConsole.RGBToColor(RGBConvertingType,RR*16,GG*16,BB*16);
      
      case bg of
        Color.Black: if (r = RGBConsole.Black.R) and (g = RGBConsole.Black.G) and (b = RGBConsole.Black.B) then Result.Symbol := 'T';
        Color.Gray: if (r = RGBConsole.Gray.R) and (g = RGBConsole.Gray.G) and (b = RGBConsole.Gray.B) then Result.Symbol := 'T';
        Color.DarkGray: if (r = RGBConsole.DarkGray.R) and (g = RGBConsole.DarkGray.G) and (b = RGBConsole.DarkGray.B) then Result.Symbol := 'T';
        Color.White: if (r = RGBConsole.White.R) and (g = RGBConsole.White.G) and (b = RGBConsole.White.B) then Result.Symbol := 'T';
        Color.DarkBlue: if (r = RGBConsole.DarkBlue.R) and (g = RGBConsole.DarkBlue.G) and (b = RGBConsole.DarkBlue.B) then Result.Symbol := 'T';
        Color.DarkGreen: if (r = RGBConsole.DarkGreen.R) and (g = RGBConsole.DarkGreen.G) and (b = RGBConsole.DarkGreen.B) then Result.Symbol := 'T';
        Color.DarkCyan: if (r = RGBConsole.DarkCyan.R) and (g = RGBConsole.DarkCyan.G) and (b = RGBConsole.DarkCyan.B) then Result.Symbol := 'T';
        Color.DarkRed: if (r = RGBConsole.DarkRed.R) and (g = RGBConsole.DarkRed.G) and (b = RGBConsole.DarkRed.B) then Result.Symbol := 'T';
        Color.DarkMagenta: if (r = RGBConsole.DarkMagenta.R) and (g = RGBConsole.DarkMagenta.G) and (b = RGBConsole.DarkMagenta.B) then Result.Symbol := 'T';
        Color.DarkYellow: if (r = RGBConsole.DarkYellow.R) and (g = RGBConsole.DarkYellow.G) and (b = RGBConsole.DarkYellow.B) then Result.Symbol := 'T';
        Color.Blue: if (r = RGBConsole.Blue.R) and (g = RGBConsole.Blue.G) and (b = RGBConsole.Blue.B) then Result.Symbol := 'T';
        Color.Green: if (r = RGBConsole.Green.R) and (g = RGBConsole.Green.G) and (b = RGBConsole.Green.B) then Result.Symbol := 'T';
        Color.Cyan: if (r = RGBConsole.Cyan.R) and (g = RGBConsole.Cyan.G) and (b = RGBConsole.Cyan.B) then Result.Symbol := 'T';
        Color.Red: if (r = RGBConsole.Red.R) and (g = RGBConsole.Red.G) and (b = RGBConsole.Red.B) then Result.Symbol := 'T';
        Color.Magenta: if (r = RGBConsole.Magenta.R) and (g = RGBConsole.Magenta.G) and (b = RGBConsole.Magenta.B) then Result.Symbol := 'T';
        Color.Yellow: if (r = RGBConsole.Yellow.R) and (g = RGBConsole.Yellow.G) and (b = RGBConsole.Yellow.B) then Result.Symbol := 'T';
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
      var bgrnd := RGBConsole.RGBToColor(RGBConvertingType, bgrnd0.A, bgrnd0.G, bgrnd0.B);
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