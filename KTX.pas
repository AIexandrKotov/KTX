{$apptype console}
{$reference 'System.Drawing.dll'}

///Модуль для удобной работы с консолью
unit KTX;

uses System.Drawing;

{$region Version}

const
  ///Название модуля
  Name = 'KTX Console Manager';
  ///Версия модуля
  Version: record Major, Minor, Build: integer; end = (Major: 2; Minor: 1; Build: 33);

///Возвращает строковое представление текущей версии модуля
function StrVersion := $'{version.Major}.{version.Minor}.{version.Build}';

///Возвращает полное имя с версией
function StrFull := $'{Name} {StrVersion}';

{$endregion Version}

{$region GlobalMethods}

///Возвращает true, если данный байт находится в диапазоне от а до b
function InRange(self: byte; a, b: byte): boolean; extensionmethod;
begin
  Result := (self >= a) and (self <= b);
end;

{$endregion GlobalMethods}

{$region SynonimTypes}
  
type

  ///Тип цвета консоли
  Color = System.ConsoleColor;
  
  ///Тип клавиши консоли
  Key = System.ConsoleKey;

{$endregion SynonimTypes}
  
{$region Colors}
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
  
{$endregion}
  
{$region Console}
type
  
  SeparateType = (
    ///Метод, основанный на списке, быстрее метода SunMethod, но выделяет лишнюю память
    ListMethod,
    ///Метод, предложенный SunSerega, медленнее на 10%, но не выделяет лишнюю память
    SunMethod
  );
  
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
    
    private static IsInit: boolean;
    
    private static _MinimalWidth: integer = 100;
    private static _MinimalHeight: integer = 30;
    
    private static procedure SetMinimalWidth(a: integer) := _MinimalWidth := a;
    private static procedure SetMinimalHeight(a: integer) := _MinimalHeight := a;
    
    ///Возвращает или задаёт минимально допустимое значение ширины экрана
    public static property MinimalWidth: integer read _MinimalWidth write SetMinimalWidth;
    ///Возвращает или задаёт минимально допустимое значение высоты экрана
    public static property MinimalHeight: integer read _MinimalHeight write SetMinimalHeight;
    
    ///Задаёт минимально допустимые значения ширины и высоты экрана
    public static procedure SetMinimalSize(x, y: integer);
    begin
      _MinimalWidth := x;
      _MinimalHeight := y;
    end;
    
    private static _width: integer = 100;
    private static _height: integer = 30;
    
    private static _cfore: Color = Black;
    private static _cback: Color = White;
    private static _cdisable: Color = Gray;
    private static _cerr: Color = Red;
    private static _ctrue: Color = DarkGreen;
    private static _cfalse: Color = Red;
    
    private static procedure SetCursorVisible(a: boolean) := System.Console.CursorVisible := a;
    
    ///Возвращает или задает видимость курсора
    public static property CursorVisible: boolean read System.Console.CursorVisible write SetCursorVisible;
    
    ///Действия, выполняемые перед чтением в блоке
    private static procedure Pre;
    begin
      System.Console.CursorVisible:=true;
    end;
    
    ///Действия, выполняемые после чтения в блоке
    private static procedure After;
    begin
      System.Console.CursorVisible:=false;
    end;
    
    ///Задаёт действительное значение цвета фона
    private static procedure SetRealBackColor(a: Color);
    begin
      System.Console.BackgroundColor := a;
    end;
    
    ///Задаёт действительное значение цвета текста
    private static procedure SetRealForeColor(a: Color);
    begin
      System.Console.ForegroundColor := a;
    end;
    
    ///Возвращает или задаёт действительное значение цвета фона консоли
    public static property RealBack: Color read System.Console.BackgroundColor write SetRealBackColor;
    
    ///Возвращает или задаёт действительное значение цвета текста консоли
    public static property RealFore: Color read System.Console.ForegroundColor write SetRealForeColor;
    
    private static procedure SetColorFore(a: Color) := _cfore := a;
    private static procedure SetColorBack(a: Color) := _cback := a;
    private static procedure SetColorDisable(a: Color) := _cdisable := a;
    private static procedure SetColorError(a: Color) := _cerr := a;
    private static procedure SetColorTrue(a: Color) := _ctrue := a;
    private static procedure SetColorFalse(a: Color) := _cfalse := a;
    
    ///Возвращает или задаёт стандартное значение цвета текста консоли
    public static property ColorFore: Color read _cfore write SetColorFore;
    
    ///Возвращает или задаёт стандартное значение цвета бэкграунда консоли
    public static property ColorBack: Color read _cback write SetColorBack;
    
    ///Возвращает или задаёт стандартное значение цвета недоступного текста консоли
    public static property ColorDisable: Color read _cdisable write SetColorDisable;
    
    ///Возвращает или задаёт стандартное значение цвета текста ошибок консоли
    public static property ColorError: Color read _cerr write SetColorError;
    
    ///Возвращает или задаёт стандартное значение цвета текста истинных значений консоли
    public static property ColorTrue: Color read _ctrue write SetColorTrue;
    
    ///Возвращает или задаёт стандартное значение цвета текста ложных значений консоли
    public static property ColorFalse: Color read _cfalse write SetColorFalse;
    
    ///Действительная высота окна консоли
    public static property RealHeight: integer read System.Console.WindowHeight;
    
    ///Действительная ширина окна консоли
    public static property RealWidth: integer read System.Console.WindowWidth;
    
    private static procedure SetWindowWidth(a: integer) := _width := a;
    private static procedure SetWindowHeight(a: integer) := _height := a;
    
    ///Возвращает или задаёт высоту окна консоли
    public static property Height: integer read _height write SetWindowHeight;
    
    ///Возвращает или задаёт ширину окна консоли
    public static property Width: integer read _width write SetWindowWidth;
    
    ///Возвращает максимальную высоту окна консоли
    public static property MaxHeight: integer read System.Console.LargestWindowHeight;
    
    ///Возвращает максимальную ширину окна консоли
    public static property MaxWidth: integer read System.Console.LargestWindowWidth;
    
    ///Устанавливает положение курсора
    public static procedure SetCursorPosition(x, y: integer) := System.Console.SetCursorPosition(x,y);
    
    ///Устанавливает положение курсора
    public static procedure SetPos(x, y: integer) := System.Console.SetCursorPosition(x, y);
    
    ///Очищает окно консоли, заливая его текущем цветом RealBack
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
    
    ///Изменяет цвет текста на цвет текста по a
    public static function BooleanColor(a: boolean): Color := a ? Console._ctrue : Console._cfalse;
    
    ///Обновляет размеры консоли
    ///Рекомендуется использовать на каждой итерации цикла
    public static procedure Resize();
    begin
      while (Console.MaxWidth<Console.MinimalWidth) or (Console.MaxHeight<Console.MinimalHeight) do
      begin
        Clear();
        Console.RealFore := Console._cerr;
        write(Err1);
        sleep(100);
        Console.RealFore := Console._cfore
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
      if size>=(_Height-start-3) then Console.SetBufferSize(size+start+3);
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
    
    ///Читает клавишу из потока, не выводя её на экран
    public static function ReadKey := System.Console.ReadKey(true);
    
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
    
    private static constructor;
    begin
      Init();
    end;
    
    private static function SizeSeparateMy(x: integer; s: array of string): sequence of string;
    begin
      var PreRes := new List<string>;
      for var i:=0 to s.Length-1 do
      begin
        var StrBuild := new StringBuilder;
        var TWds := s[i].ToWords;
        if TWds<>nil then
          for var j:=0 to TWds.Length-1 do
          begin
            if StrBuild.length + TWds[j].length < x then
            begin
              if j>0 then StrBuild+=' ';
              StrBuild += TWds[j];
            end
            else
            begin
              PreRes += StrBuild.ToString;
              StrBuild := TWds[j];
            end;
          end;
        if StrBuild.ToString<>'' then
          PreRes += StrBuild.ToString;
      end;
      Result := PreRes;
    end;
    
    private static function SizeSeparateMy(x: integer; s: string) := SizeSeparateMy(x, new string[](s));
  
    private static function SizeSeparateSun(x: integer; s: array of string): sequence of string;
    begin
      var res := new StringBuilder(x);
      
      foreach var nw in s.SelectMany(l -> l.ToWords()) do
      begin
        var w: string;
        if res.Length=0 then
          w := nw else
          w := ' ' + nw;
        
        if res.Length + w.Length < x then
          res.Append(w) else
        begin
          //yield res.ToString; TODO
          res.Clear;
          res.Append(nw);
        end;
      end;
      if res.Length <> 0 then
        //yield res.ToString; TODO
    end;
    
    private static function SizeSeparateSun(x: integer; s: string): sequence of string;
    begin
      Result := SizeSeparateSun(x, new string[](s));
    end;
  
    private static _separatetype: SeparateType := SeparateType.ListMethod;
    
    private static procedure SetSizeSeparateType(a: SeparateType) := _separatetype := a;
    
    ///Возвращает или задаёт тип разделения текста по строкам
    public static property SizeSeparateType: SeparateType read _separatetype write SetSizeSeparateType;
    
    ///Возвращает последовательность строк, разделённых по заданной длине способом переноса t
    public static function SizeSeparate(t: SeparateType; x: integer; params s: array of string): sequence of string;
    begin
      case t of
        SeparateType.ListMethod: Result := SizeSeparateMy(x, s);
        //SeparateType.SunMethod: Result := SizeSeparateSun(x, s);
        else raise new System.Exception;
      end;
    end;
    
    ///Возвращает последовательность строк, разделённых по ширине консоли способом переноса t
    public static function SizeSeparate(t: SeparateType; params s: array of string) := SizeSeparate(t, _width, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям способом переноса t
    public static function SizeSeparateWSpaces(t: SeparateType; params s: array of string) := SizeSeparate(t, _width - 2, s);
    
    ///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
    public static function SizeSeparate(x: integer; params s: array of string): sequence of string := SizeSeparate(_separatetype, x, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
    public static function SizeSeparate(params s: array of string): sequence of string := SizeSeparate(_separatetype, _width, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
    public static function SizeSeparateWSpaces(params s: array of string): sequence of string := SizeSeparate(_separatetype, _width - 2, s);
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
    ///--
    private _inthistick: boolean;
    ///--
    private _last: boolean;
    
    ///Изменяет вывод
    private procedure SetOut(a: integer);
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
      _input := Null;
      _output := Zero;
      _inthistick := false;
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
          Console.SetCursorPosition(1,size+start+2);
          Console.SetCursorPosition(1,size+start+1);
        end
        else Console.SetCursorPosition(1,Console.Height-2);
        write(': ');
        readln(s);
      end;
      _input:=s;
      Console.After;
    end;
    
    ///Даёт свойству Output числовое значение Input, возвращает true, если преобразование выполнено успешно
    ///Если rec = false, то на одной итерации цикла проводит действие только один раз
    public function CalculateOut(rec: boolean): boolean;
    begin
      if (not _inthistick) or (rec) then
      begin
        var e: integer;
        
        val(_input, _output, e);
        if e = 0 then _last := true else _last := false;
        
        Result := _last;
        _inthistick := true;
      end else Result := _last;
    end;
    
    ///Даёт свойству Output числовое значение Input, возвращает true, если преобразование выполнено успешно
    ///На каждой итерации цикла проводит действие только один раз
    public function CalculateOut: boolean := CalculateOut(false);
    
    ///Даёт свойству Output числовое значение Input, возвращает true, если преобразование выполнено успешно
    ///На каждой итерации цикла проводит действие сколь угодно раз
    public function RecalculateOut: boolean := CalculateOut(true);
    
    ///Возвращает значение, является ли Input является целым числом
    public property OutIsDigit: boolean read CalculateOut;
    
    ///Возвращает Input текущего псевдоокна
    public function ToString: string; override := _input;
  end;
  
  ///Представляет класс псевдоокна, который управляется клавишами
  KeyBlock = class
    ///-
    private _status: boolean;
    ///-
    private _stage: array of integer;
    ///-
    private _input: System.ConsoleKeyInfo;
    
    ///Состояние блока
    public property Status: boolean read _status;
    
    ///Целочисленные параметры блока
    public property Stage: array of integer read _stage;
    
    ///Возвращает информацию о введённой клавише
    public property Input: System.ConsoleKeyInfo read _input;
    
    ///Возвращает нажатую клавишу
    public function GetInputKey := _input.Key;
    
    ///Чтение клавиши
    public procedure Read;
    begin
      _input := System.Console.ReadKey(true);
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
    
    ///Изменяет значение параметра блока id на значение value
    public procedure SetStage(id, value: integer) := _stage[id] := value;
    
    ///Изменяет размер параметров блока
    public procedure SetSize(length: integer) := SetLength(_stage,length);
    
    ///Закрывает данный блок
    public procedure Close();
    begin
      _status := false;
    end;
    
    ///Создаёт новый экземпляр класс KeyBlock
    public constructor;
    begin
      Console.After;
      if not Console.IsInit then Console.Init;
      _status := true;
      _stage := new integer[1];
      _stage[0] := 1;
    end;
    
    ///Создаёт новый экземпляр с указанным числом параметров
    public constructor(a: integer);
    begin
      Console.After;
      if not Console.IsInit then Console.Init;
      _status := true;
      _stage := new integer[a];
      for var i:=0 to _stage.Length-1 do _stage[i] := 1;
    end;
    
    ///--
    public static function operator implicit(a: KeyBlock): boolean := a._status;
  end;

{$region SizeSeparates Overloads}

///Возвращает последовательность строк, разделённых по заданной длине способом переноса t
function SizeSeparate(t: SeparateType; x: integer; params s: array of string) := Console.SizeSeparate(t, x, s);

///Возвращает последовательность строк, разделённых по заданной длине способом переноса t
function SizeSeparate(self: array of string; t: SeparateType; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(t, x, self);

///Возвращает последовательность строк, разделённых по заданной длине способом переноса t
function SizeSeparate(self: string; t: SeparateType; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(t, x, self);

///Возвращает последовательность строк, разделённых по ширине консоли способом переноса t
function SizeSeparate(t: SeparateType; params s: array of string) := Console.SizeSeparate(t, Console._width, s);

///Возвращает последовательность строк, разделённых по ширине консоли способом переноса t
function SizeSeparate(self: array of string; t: SeparateType): sequence of string; extensionmethod := Console.SizeSeparate(t, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли способом переноса t
function SizeSeparate(self: string; t: SeparateType): sequence of string; extensionmethod := Console.SizeSeparate(t, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям способом переноса t
function SizeSeparateWSpaces(t: SeparateType; params s: array of string) := Console.SizeSeparate(t, Console._width - 2, s);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям способом переноса t
function SizeSeparateWSpaces(self: array of string; t: SeparateType): sequence of string; extensionmethod := Console.SizeSeparate(t, Console._width - 2, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям способом переноса t
function SizeSeparateWSpaces(self: string; t: SeparateType): sequence of string; extensionmethod := Console.SizeSeparate(t, Console._width - 2, self);

///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
function SizeSeparate(x: integer; params s: array of string) := Console.SizeSeparate(Console._separatetype, x, s);

///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
function SizeSeparate(self: array of string; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, x, self);

///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
function SizeSeparate(self: string; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, x, self);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(params s: array of string) := Console.SizeSeparate(Console._separatetype, Console._width, s);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(self: array of string): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(self: string): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(params s: array of string) := Console.SizeSeparate(Console._separatetype, Console._width - 2, s);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(self: array of string): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, Console._width - 2, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(self: string): sequence of string; extensionmethod := Console.SizeSeparate(Console._separatetype, Console._width - 2, self);

///Выводит последовательность строк, полученных методом SizeSeparateWSpaces, начиная со строки y
///Возвращает саму последовательность
function PrintSeparated(self: sequence of string; y: integer): sequence of string; extensionmethod;
begin
  Console.SetCursorPosition(0, y);
  foreach var x in self do writeln($' {x}');
  Result := self;
end;

///Выводит последовательность строк, полученных методом SizeSeparateWSpaces, начиная со второй строки
///Возвращает саму последовательность
function PrintSeparated(self: sequence of string): sequence of string; extensionmethod := self.PrintSeparated(1);

{$endregion SizeSeparates Overloads}

{$endregion Console}
  
{$region Drawing}
type
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
  RGBToColorConvertType = (
    ///Тип конвертации версии 2.0.2
    ///Больше подходит для чёрно-белых фотографий
    v20,
    ///Новый тип конвертации
    &New,
    ///Экспериментальный тип конвертации
    Exp64,
    ///Экспериментальный тип конвертации
    Exp128
  );
  
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
    
    public static function ColorEquality(c: Color; R, G, B: byte): boolean;
    begin
      Result := false;
      case c of
        Color.Black: if (r = _Black.R) and (g = _Black.G) and (b = _Black.B) then Result := true;
        Color.Gray: if (r = _Gray.R) and (g = _Gray.G) and (b = _Gray.B) then Result := true;
        Color.DarkGray: if (r = _DarkGray.R) and (g = _DarkGray.G) and (b = _DarkGray.B) then Result := true;
        Color.White: if (r = _White.R) and (g = _White.G) and (b = _White.B) then Result := true;
        Color.DarkBlue: if (r = _DarkBlue.R) and (g = _DarkBlue.G) and (b = _DarkBlue.B) then Result := true;
        Color.DarkGreen: if (r = _DarkGreen.R) and (g = _DarkGreen.G) and (b = _DarkGreen.B) then Result := true;
        Color.DarkCyan: if (r = _DarkCyan.R) and (g = _DarkCyan.G) and (b = _DarkCyan.B) then Result := true;
        Color.DarkRed: if (r = _DarkRed.R) and (g = _DarkRed.G) and (b = _DarkRed.B) then Result := true;
        Color.DarkMagenta: if (r = _DarkMagenta.R) and (g = _DarkMagenta.G) and (b = _DarkMagenta.B) then Result := true;
        Color.DarkYellow: if (r = _DarkYellow.R) and (g = _DarkYellow.G) and (b = _DarkYellow.B) then Result := true;
        Color.Blue: if (r = _Blue.R) and (g = _Blue.G) and (b = _Blue.B) then Result := true;
        Color.Green: if (r = _Green.R) and (g = _Green.G) and (b = _Green.B) then Result := true;
        Color.Cyan: if (r = _Cyan.R) and (g = _Cyan.G) and (b = _Cyan.B) then Result := true;
        Color.Red: if (r = _Red.R) and (g = _Red.G) and (b = _Red.B) then Result := true;
        Color.Magenta: if (r = _Magenta.R) and (g = _Magenta.G) and (b = _Magenta.B) then Result := true;
        Color.Yellow: if (r = _Yellow.R) and (g = _Yellow.G) and (b = _Yellow.B) then Result := true;
      end;
    end;
    
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
      if ((R.InRange(96,159)) and (G.InRange(128,255)) and (B.InRange(0,63)))
      or ((R.InRange(96,159)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _darkyellow.ConsoleColor;
      
      //Тёмно-голубой цвет
      if (R.InRange(0,95)) and (G.InRange(64,191)) and (B.InRange(64,191)) then Result := _darkcyan.ConsoleColor;
      
      //Красный цвет
      if ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(64,127)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(64,127))) then Result := _red.ConsoleColor;
      
      //Зелёный цвет
      if ((R.InRange(0,95)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _green.ConsoleColor;
      
      //Синий цвет
      if ((R.InRange(0,95)) and (G.InRange(0,127)) and (B.InRange(160,225))) then Result := _blue.ConsoleColor;
      
      //Пурпурный цвет
      if ((R.InRange(160,255)) and (G.InRange(0,63)) and (B.InRange(128,255)))
      or ((R.InRange(160,255)) and (G.InRange(64,127)) and (B.InRange(192,255))) then Result := _magenta.ConsoleColor;
      
      //Жёлтый цвет
      if ((R.InRange(160,255)) and (G.InRange(128,255)) and (B.InRange(0,63)))
      or ((R.InRange(160,255)) and (G.InRange(192,255)) and (B.InRange(0,127))) then Result := _yellow.ConsoleColor;
      
      //Голубой цвет
      if ((R.InRange(0,95)) and (G.InRange(128,255)) and (B.InRange(160,255)))
      or ((R.InRange(0,95)) and (G.InRange(160,255)) and (B.InRange(128,255))) then Result := _cyan.ConsoleColor;
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
        v20: Result := OldRGBToColor(r, g, b);
        &New, Exp64, Exp128: Result := FromRGB(r, g, b);
        else raise new System.Exception;
      end;
    end;
    
    ///Старое преобразование RGB на основе текущего цвета в набор (1..16, 1..16, 1..16)
    ///Служит для определения цвета текста
    public static function OldRGBToSubColor(a: KTX.Color; r, g, b: byte): (integer, integer, integer);
    begin
      case a of
        Color.Black, Color.DarkBlue, Color.DarkGreen, Color.DarkCyan, Color.DarkMagenta, Color.DarkYellow, Color.DarkRed:
          Result := ((r mod 64) div 4 + 1, (g mod 64) div 4 + 1, (b mod 64) div 4 + 1);
        Color.Blue, Color.Green, Color.Cyan, Color.Magenta, Color.Yellow, Color.Red:
          Result := (
            r < 128 ? (r mod 64) div 4 + 1 : 16 - (r mod 64) div 4,
            g < 128 ? (g mod 64) div 4 + 1 : 16 - (g mod 64) div 4,
            b < 128 ? (b mod 64) div 4 + 1 : 16 - (b mod 64) div 4
          );
        Color.DarkGray: Result := (((r - 64) mod 96) div 6 + 1, ((g - 64) mod 96) div 6 + 1, ((b - 64) mod 96) div 6 + 1);
        Color.Gray: Result := (16 - ((r - 160) mod 96) div 6, 16 - ((g - 160) mod 96) div 6, 16 - ((b - 160) mod 96) div 6);
        Color.White: Result := (16 - ((r - 224) mod 32) div 2, 16 - ((g - 224) mod 32) div 2, 16 - ((b - 224) mod 32) div 2);
      end;
    end;
    
    ///Новое проеобразование RGB на основе текущего цвета в набор (1..16, 1..16, 1..16)
    ///Служит для определения цвета текста
    public static function NewRGBToSubColor(a: KTX.Color; r, g, b: byte): (integer, integer, integer);
    begin
      case a of      
        Color.Black:
          Result := ((r mod 64) div 4 + 1, (g mod 64) div 4 + 1, (b mod 64) div 4 + 1);
        Color.DarkGray:
          Result := (
            r < 128 ? (r mod 32) div 2 + 1 : 16 - (r mod 128) div 8,
            g < 128 ? (g mod 32) div 2 + 1 : 16 - (g mod 128) div 8,
            b < 128 ? (b mod 32) div 2 + 1 : 16 - (b mod 128) div 8
          );
        Color.Gray:
          Result := (
            16 - (r mod 96) div 6,
            g < 128 ? (g mod 32) div 2 + 1 : 16 - (g mod 128) div 8,
            b < 128 ? (b mod 32) div 2 + 1 : 16 - (b mod 128) div 8
          );
        Color.White:
          Result := (
            16 - (r mod 96) div 6,
            g < 128 ? (g mod 32) div 2 + 1 : 16 - (g mod 128) div 8,
            b < 128 ? (b mod 32) div 2 + 1 : 16 - (b mod 128) div 8
          );
        Color.DarkRed:
          Result := (
            r < 128 ? (r mod 32) div 2 + 1 : 16 - (r mod 32) div 2,
            (g mod 128) div 8 + 1,
            (b mod 128) div 8 + 1 
          );
        Color.DarkGreen:
          Result := (
            (r mod 96) div 6 + 1,
            g < 128 ? (g mod 64) div 4 + 1 : 16 - (g mod 64) div 4,
            (b mod 64) div 4 + 1
          );
        Color.DarkBlue:
          Result := (
            (r mod 96) div 6 + 1,
            (g mod 64) div 4 + 1,
            b < 128 ? (b mod 64) div 4 + 1 : 16 - (b mod 64) div 4
          );
        Color.DarkMagenta:
          Result := (
            r < 128 ? (r mod 32) div 2 + 1 : 16 - (r mod 32) div 2,
            (g mod 128) div 8 + 1,
            16 - (b mod 128) div 8
          );
        Color.DarkYellow:
          Result := (
            r < 128 ? (r mod 32) div 2 + 1 : 16 - (r mod 32) div 2,
            16 - (g mod 128) div 8,
            (b mod 128) div 8 + 1
          );
        Color.DarkCyan:
          Result := (
            (r mod 96) div 6 + 1,
            g < 128 ? (g mod 64) div 4 + 1: 16 - (g mod 64) div 4,
            b < 128 ? (b mod 64) div 4 + 1: 16 - (b mod 64) div 4
          );
        Color.Red:
          Result := (
            16 - (r mod 96) div 6,
            (g mod 128) div 8 + 1,
            (b mod 128) div 8 + 1
          );
        Color.Green:
          Result := (
            (r mod 96) div 6 + 1,
            16 - (g mod 64) div 4,
            (b mod 128) div 8 + 1
          );
        Color.Blue:
          Result := (
            (r mod 96) div 6 + 1,
            (g mod 128) div 8 + 1,
            16 - (b mod 96) div 6
          );
        Color.Magenta:
          Result := (
            16 - (r mod 96) div 6,
            (g mod 128) div 8 + 1,
            16 - (b mod 128) div 8
          );
        Color.Yellow:
          Result := (
            16 - (r mod 96) div 6,
            16 - (g mod 128) div 8,
            (b mod 128) div 8 + 1
          );
        Color.Cyan:
          Result := (
            (r mod 96) div 6 + 1,
            16 - (g mod 128) div 8,
            16 - (b mod 128) div 8
          );
      end;
    end;
    
    public static function Experimental128(a: KTX.Color; r, g, b: byte): (integer, integer, integer);
    begin
      Result := (
        r < 128 ? (r mod 128) div 8 + 1 : 16 - (r mod 128) div 8,
        g < 128 ? (g mod 128) div 8 + 1 : 16 - (g mod 128) div 8,
        b < 128 ? (b mod 128) div 8 + 1 : 16 - (b mod 128) div 8
      );
    end;
    
    public static function Experimental64(a: KTX.Color; r, g, b: byte): (integer, integer, integer);
    begin
      Result := (
        r < 128 ? (r mod 64) div 4 + 1 : 16 - (r mod 64) div 4,
        g < 128 ? (g mod 64) div 4 + 1 : 16 - (g mod 64) div 4,
        b < 128 ? (b mod 64) div 4 + 1 : 16 - (b mod 64) div 4
      );
    end;
    
    ///t-Преобразование RGB на основе текущего цвета в набор (1..16, 1..16, 1..16)
    public static function RGBToSubColor(t: RGBToColorConvertType; a: KTX.Color; r, g, b: byte): (integer, integer, integer);
    begin
      case t of
        RGBToColorConvertType.v20: Result := (OldRGBToSubColor(a, r, g, b));
        RGBToColorConvertType.New: Result := (NewRGBToSubColor(a, r, g, b));
        RGBToColorConvertType.Exp64: Result := (Experimental64(a, r, g, b));
        RGBToColorConvertType.Exp128: Result := (Experimental128(a, r, g, b));
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
  
  ///Представляет типы центровки
  DrawingAlignmentType = (
    ///Отцентровка относительно левого верхнего угла
    LeftUp,
    ///Отцентровка относительно верхней стороны
    Up,
    ///Отцентровка относитльно правого верхнего угла
    RightUp,
    ///Отцентровка относительно левой стороны
    Left,
    ///Отцентровка по центру
    Center,
    ///Отцентровка относительно правой стороны
    Right,
    ///Отцентровка относительно левого нижнего угла
    LeftDown,
    ///Отцентровка относительно нижней стороны
    Down,
    ///Отцентровка относительно правого нижнего угла
    RightDown
  );
  
  ///Представляет типы рисования
  DrawingType = (
    ///Рисование всех строк
    Aline,
    ///Рисования всего по цвету
    Hex
  );
  
  ///Содержит методы для рисования
  Drawing = static class
    ///Символы вывода
    public const Context = ' .:;t08SX%&#@░▒▓';
    private static _RGBConvertingType: RGBToColorConvertType := RGBToColorConvertType.New;
    private static _DefaultAlignmentType: DrawingAlignmentType := DrawingAlignmentType.Center;
    private static _DefaultIsOverlay := false;
    private static _DefaultDrawingType: DrawingType := DrawingType.Aline;
    
    private static procedure SetRGBConveringType(a: RGBToColorConvertType) := _RGBConvertingType := a;
    private static procedure SetDefaultAlignmentType(a: DrawingAlignmentType) := _DefaultAlignmentType := a;
    private static procedure SetDefaultIsOverlay(a: boolean) := _DefaultIsOverlay := a;
    private static procedure SetDefaultDrawingType(a: DrawingType) := _DefaultDrawingType := a;
    
    ///Возвращает или задаёт стандартную конвертацию цвета
    public static property RGBConvertingType: RGBToColorConvertType read _RGBConvertingType write SetRGBConveringType;
    
    ///Возвращает или задаёт стандартную отцентровку рисунка
    public static property DefaultAlignmentType: DrawingAlignmentType read _DefaultAlignmentType write SetDefaultAlignmentType;
    
    ///Возвращает или задаёт стандартный параметр наложения
    public static property DefaultIsOverlay: boolean read _DefaultIsOverlay write SetDefaultIsOverlay;
    
    ///Возвращает или задаёт стандартный тип рисования
    public static property DefaultDrawingType: DrawingType read _DefaultDrawingType write SetDefaultDrawingType;
    
    ///Преобразует ARGB (4 байтовое) представление цвета в DrawBox
    public static function ARGBPixelToDrawBox(x, y: integer; bg: Color; a, r, g, b: byte): DrawBox;
    begin
      Result := new DrawBox();
      
      Result.PosX := x;
      Result.PosY := y;
      Result.Symbol:=' ';
      Result.Back:=RGBConsole.RGBToColor(_RGBConvertingType,r,g,b);
      
      var RR, GG, BB: integer;
      
      (RR, GG, BB) := RGBConsole.RGBToSubColor(_RGBConvertingType,Result.Back, r, g, b);
      
      Result.Fore := RGBConsole.RGBToColor(_RGBConvertingType, RR*16, GG*16, BB*16);
      Result.Symbol := Context[Arr(RR, GG, BB).Average.Round];
      
      if RGBConsole.ColorEquality(bg,r,g,b) then Result.Symbol := 'T';
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
      var bgrnd := RGBConsole.RGBToColor(_RGBConvertingType, bgrnd0.A, bgrnd0.G, bgrnd0.B);
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
      
      b.Dispose;
    end;
    
    ///Преобразует файл-рисунок bmpname в файл .ktx
    public static procedure BitMapToKTXFile(bmpname, ktxname: string);
    begin
      BitMapToDrawBoxBlock(bmpname).WriteKTXFile(ktxname);
    end;
    
    ///Возвращает позицию в консоли левого верхнего угла картинки с учётом заданного центрирования
    public static function GetStartPos(a: DrawBoxBlock; AlignementType: DrawingAlignmentType): (integer, integer);
    begin
      case AlignementType of
        LeftUp: Result := (0,0);
        Up: Result := ((Console.Width - a.SizeX) div 2, 0);
        RightUp: Result := ((Console.Width - a.SizeX), 0);
        
        Left: Result := (0, (Console.Height - a.SizeY) div 2);
        Center: Result := ((Console.Width - a.SizeX) div 2,(Console.Height -  a.SizeY) div 2);
        Right: Result := ((Console.Width - a.SizeX), (Console.Height - a.SizeY) div 2);
        
        LeftDown: Result := (0, (Console.Height - a.SizeY));
        Down: Result := ((Console.Width - a.SizeX) div 2, (Console.Height - a.SizeY));
        RightDown: Result := ((Console.Width - a.SizeX), (Console.Height - a.SizeY));
      end;
    end;
    
    ///Возвращает позицию в консоли левого верхнего угла картинки с учётом стандартного центрирования
    public static function GetStartPos(a: DrawBoxBlock) := GetStartPos(a, _DefaultAlignmentType);
    
    ///Построчное рисование a от позиции (x, y) и параметром наложения isoverlay
    public static procedure AlineDraw(a: DrawBoxBlock; x, y: integer; isoverlay: boolean);
    begin
      System.Console.BackgroundColor:=a.Background;
      if not isoverlay then Console.Clear;
      for var i:=0 to a.Draws.Length-1 do
      begin
        Console.SetCursorPosition(a.Draws[i].PosX+x,a.Draws[i].PosY+y);
        System.Console.BackgroundColor:=a.Draws[i].Back;
        System.Console.ForegroundColor:=a.Draws[i].Fore;
        write(a.Draws[i].Symbol);
      end;
    end;
    
    ///Построчное рисование a от позиции x и параметром наложения isoverlay
    public static procedure AlineDraw(a: DrawBoxBlock; x: (integer, integer); isoverlay: boolean) := AlineDraw(a, x.Item1, x.Item2, isoverlay);
    
    ///Построчное рисование a от позиции x и стандартным параметром наложения
    public static procedure AlineDraw(a: DrawBoxBlock; x: (integer, integer)) := AlineDraw(a, x, _DefaultIsOverlay);
    
    ///Построчное рисование a от позиции (x, y) и стандартным параметром наложения
    public static procedure AlineDraw(a: DrawBoxBlock; x, y: integer) := AlineDraw(a, x, y, _DefaultIsOverlay);
    
    ///Построчное рисование a с отцентровкой At и параметром наложения isoverlay
    public static procedure AlineDraw(a: DrawBoxBlock; At: DrawingAlignmentType; isoverlay: boolean) := AlineDraw(a, GetStartPos(a,At),isoverlay);
    
    ///Построчное рисование a с отцентровкой At и стандартным параметром наложения
    public static procedure AlineDraw(a: DrawBoxBlock; At: DrawingAlignmentType) := AlineDraw(a, GetStartPos(a,At), _DefaultIsOverlay);
    
    ///Построчное рисование a с стандартной отцентровкой и параметром наложения isoverlay
    public static procedure AlineDraw(a: DrawBoxBlock; isoverlay: boolean) := AlineDraw(a, _DefaultAlignmentType, isoverlay);
    
    ///Построчное рисование a с стандартной отцентровкой и стандартным параметром наложения
    public static procedure AlineDraw(a: DrawBoxBlock) := AlineDraw(a, _DefaultIsOverlay);
    
    ///Поцветовое рисование a от позиции (x, y) и параметром наложения isoverlay
    public static procedure HexDraw(a: DrawBoxBlock; x, y: integer; isoverlay: boolean);
    begin
      System.Console.BackgroundColor:=a.Background;
      if not isoverlay then Console.Clear;
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
    
    ///Поцветовое рисование a от позиции x и параметром наложения isoverlay
    public static procedure HexDraw(a: DrawBoxBlock; x: (integer, integer); isoverlay: boolean) := HexDraw(a, x.Item1, x.Item2, isoverlay);
    
    ///Поцветовое рисование a от позиции x и стандартным параметром наложения
    public static procedure HexDraw(a: DrawBoxBlock; x: (integer, integer)) := HexDraw(a, x, _DefaultIsOverlay);
    
    ///Поцветовое рисование a от позиции (x, y) и стандартным параметром наложения
    public static procedure HexDraw(a: DrawBoxBlock; x, y: integer) := HexDraw(a, x, y, _DefaultIsOverlay);
    
    ///Поцветовое рисование a с отцентровкой At и параметром наложения isoverlay
    public static procedure HexDraw(a: DrawBoxBlock; At: DrawingAlignmentType; isoverlay: boolean) := HexDraw(a, GetStartPos(a,At),isoverlay);
    
    ///Поцветовое рисование a с отцентровкой At и стандартным параметром наложения
    public static procedure HexDraw(a: DrawBoxBlock; At: DrawingAlignmentType) := HexDraw(a, GetStartPos(a,At), _DefaultIsOverlay);
    
    ///Поцветовое рисование a с стандартной отцентровкой и параметром наложения isoverlay
    public static procedure HexDraw(a: DrawBoxBlock; isoverlay: boolean) := HexDraw(a, _DefaultAlignmentType, isoverlay);
    
    ///Поцветовое рисование a с стандартной отцентровкой и стандартным параметром наложения
    public static procedure HexDraw(a: DrawBoxBlock) := HexDraw(a, _DefaultIsOverlay);
    
    ///Dt-рисование a от позиции (x, y) и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; x, y: integer; isoverlay: boolean);
    begin
      case Dt of
        DrawingType.Aline: AlineDraw(a, x, y, isoverlay);
        DrawingType.Hex: HexDraw(a, x, y, isoverlay);
      end;
    end;
    
    ///Dt-рисование a от позиции x и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; x: (integer, integer); isoverlay: boolean) := Draw(a, Dt, x.Item1, x.Item2, isoverlay);
    
    ///Dt-рисование a от позиции x и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; x: (integer, integer)) := Draw(a, Dt, x, _DefaultIsOverlay);
    
    ///Dt-рисование a от позиции (x, y) и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; x, y: integer) := Draw(a, Dt, x, y, _DefaultIsOverlay);
    
    ///Dt-рисование a с отцентровкой At и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; At: DrawingAlignmentType; isoverlay: boolean) := Draw(a, Dt, GetStartPos(a,At), isoverlay);
    
    ///Dt-рисование a с отцентровкой At и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; At: DrawingAlignmentType) := Draw(a, Dt, GetStartPos(a,At), _DefaultIsOverlay);
    
    ///Dt-рисование a с стандартной отцентровкой и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType; isoverlay: boolean) := Draw(a, Dt, _DefaultAlignmentType, isoverlay);
    
    ///Dt-рисование a с стандартной отцентровкой и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; Dt: DrawingType) := Draw(a, Dt, _DefaultIsOverlay);
    
    ///Стандартное рисование a от позиции (x, y) и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; x, y: integer; isoverlay: boolean) := Draw(a, Drawing._DefaultDrawingType, x, y, isoverlay);
    
    ///Стандартное рисование a от позиции x и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; x: (integer, integer); isoverlay: boolean) := Draw(a, _DefaultDrawingType, x.Item1, x.Item2, isoverlay);
    
    ///Стандартное рисование a от позиции x и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; x: (integer, integer)) := Draw(a, _DefaultDrawingType, x, _DefaultIsOverlay);
    
    ///Стандартное рисование a от позиции (x, y) и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; x, y: integer) := Draw(a, _DefaultDrawingType, x, y, _DefaultIsOverlay);
    
    ///Стандартное рисование a с отцентровкой At и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; At: DrawingAlignmentType; isoverlay: boolean) := Draw(a, _DefaultDrawingType, GetStartPos(a,At),isoverlay);
    
    ///Стандартное рисование a с отцентровкой At и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock; At: DrawingAlignmentType) := Draw(a, _DefaultDrawingType, GetStartPos(a,At), _DefaultIsOverlay);
    
    ///Стандартное рисование a с стандартной отцентровкой и параметром наложения isoverlay
    public static procedure Draw(a: DrawBoxBlock; isoverlay: boolean) := Draw(a, _DefaultDrawingType, _DefaultAlignmentType, isoverlay);
    
    ///Стандартное рисование a с стандартной отцентровкой и стандартным параметром наложения
    public static procedure Draw(a: DrawBoxBlock) := Draw(a, _DefaultDrawingType, _DefaultIsOverlay);
  end;

///Изменяет размер консоли на размер переданного рисунка и возвращает этот же рисунок
function SetSize(self: DrawBoxBlock): DrawBoxBlock; extensionmethod;
begin
  Result := self;
  Console.SetWindowSize(self.SizeX,self.SizeY);
  Console.SetBufferSize(self.SizeX,self.SizeY);
end;

///Рисует текущий объект в консоли типом рисования Dt с позиции (x, y) и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; x, y: integer; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Dt, x, y, isoverlay);

///Рисует текущий объект в консоли типом рисования Dt с позиции x и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(Self, Dt, x.Item1, x.Item2, isoverlay);

///Рисует текущий объект в консоли типом рисования Dt с позиции x и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; x: (integer, integer)); extensionmethod := Drawing.Draw(self, Dt, x, Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли типом рисования Dt с позиции (x, y) и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; x, y: integer); extensionmethod := Drawing.Draw(self, Dt, x, y, Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли типом рисования Dt с отцентровкой At и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Dt, Drawing.GetStartPos(self,At),isoverlay);

///Рисует текущий объект в консоли типом рисования Dt с отцентровкой At и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; At: DrawingAlignmentType); extensionmethod := Drawing.Draw(self, Dt, Drawing.GetStartPos(self, At), Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли типом рисования Dt с стандартной отцентровкой и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; Dt: DrawingType; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Dt, Drawing._DefaultAlignmentType, isoverlay);

///Рисует текущий объект в консоли типом рисования Dt с стандартной отцентровкой и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; Dt: DrawingType); extensionmethod := Drawing.Draw(self, Dt, Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли стандартным типом рисования с позиции (x, y) и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; x, y: integer; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, x, y, isoverlay);

///Рисует текущий объект в консоли стандартным типом рисования с позиции x и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, x.Item1, x.Item2, isoverlay);

///Рисует текущий объект в консоли стандартным типом рисования с позиции x и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; x: (integer, integer)); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, x, Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли стандартным типом рисования с позиции (x, y) и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; x, y: integer); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, x, y, Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли стандартным типом рисования с отцентровкой At и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, Drawing.GetStartPos(self,At),isoverlay);

///Рисует текущий объект в консоли стандартным типом рисования с отцентровкой At и стандартным параметром наложения
procedure Draw(self: DrawBoxBlock; At: DrawingAlignmentType); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, Drawing.GetStartPos(self,At), Drawing._DefaultIsOverlay);

///Рисует текущий объект в консоли стандартным типом рисования с стандартной отцентровкой и параметром наложения isoverlay
procedure Draw(self: DrawBoxBlock; isoverlay: boolean); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, Drawing._DefaultAlignmentType, isoverlay);

///Рисует текущий объект в консоли со всеми стандартными значениями
procedure Draw(self: DrawBoxBlock); extensionmethod := Drawing.Draw(self, Drawing._DefaultDrawingType, Drawing._DefaultIsOverlay);

{$endregion Drawing}
  
begin
  
end.