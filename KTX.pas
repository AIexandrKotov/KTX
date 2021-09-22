{$apptype console}
{$reference 'System.Drawing.dll'}

///Модуль для удобной работы с консолью
unit KTX;

uses System.Drawing;
uses System.Threading.Tasks;

{$region Version}

const
  ///Название модуля
  Name = 'KTX Console Manager';
  ///Версия модуля
  Version: record Major, Minor, SubMinor, Build: integer; end = (Major: 2; Minor: 3; SubMinor: 0; Build: 50);

///Возвращает строковое представление текущей версии модуля
function StrVersion := $'{version.Major}.{version.Minor}.{version.SubMinor}';

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
    
    ///Название консольного окна
    public static property Title: string read System.Console.Title write System.Console.Title := value;
    
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
    
    ///Задаёт размеры окна консоли текущими значениями ширины и высоты окна
    public static procedure SetWindowSize() := System.Console.SetWindowSize(_width, _height);
    
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
    
    private static function _WindowSizeIsActual := (System.Console.WindowHeight=_Height) and (System.Console.WindowWidth=_Width);
    
    ///Возвращает true, если размер консоли соответствует размеру окна консоли
    public static property WindowSizeIsActual: boolean read _WindowSizeIsActual;
    
    ///Устанавливает положение курсора
    public static procedure SetCursorPosition(x, y: integer) := System.Console.SetCursorPosition(x,y);
    
    ///Устанавливает положение курсора
    public static procedure SetPos(x, y: integer) := System.Console.SetCursorPosition(x, y);
    
    ///Очищает окно консоли, заливая его текущем цветом RealBack
    public static procedure Clear() := System.Console.Clear();
    
    ///Задаёт размеры окна консоли
    public static procedure SetWindowSize(x, y: integer);
    begin
      _width:=x;
      _height:=y;
      System.Console.SetWindowSize(x, y);
    end;
    
    public static procedure SetSize(x, y: integer);
    begin
      SetWindowSize(x, y);
      SetBufferSize(x, y);
      Resize();
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
    
    ///Возвращает или задает позицию столбца курсора
    public static property CursorLeft: integer read System.Console.CursorLeft write System.Console.CursorLeft := value;
    
    ///Возвращает или задает позицию строки курсора
    public static property CursorTop: integer read System.Console.CursorTop write System.Console.CursorTop := value;
    
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
          yield res.ToString;
          res.Clear;
          res.Append(nw);
        end;
      end;
      if res.Length <> 0 then
        yield res.ToString;
    end;
    
    private static function SizeSeparateSun(x: integer; s: string): sequence of string;
    begin
      Result := SizeSeparateSun(x, new string[](s));
    end;
    
    ///Возвращает или задаёт тип разделения текста по строкам
    public static auto property SizeSeparateType: SeparateType;
    
    ///Возвращает последовательность строк, разделённых по заданной длине способом переноса t
    public static function SizeSeparate(t: SeparateType; x: integer; params s: array of string): sequence of string;
    begin
      case t of
        SeparateType.ListMethod: Result := SizeSeparateMy(x, s);
        SeparateType.SunMethod: Result := SizeSeparateSun(x, s);
        else raise new System.Exception;
      end;
    end;
    
    ///Возвращает последовательность строк, разделённых по ширине консоли способом переноса t
    public static function SizeSeparate(t: SeparateType; params s: array of string) := SizeSeparate(t, _width, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям способом переноса t
    public static function SizeSeparateWSpaces(t: SeparateType; params s: array of string) := SizeSeparate(t, _width - 2, s);
    
    ///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
    public static function SizeSeparate(x: integer; params s: array of string): sequence of string := SizeSeparate(SizeSeparateType, x, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
    public static function SizeSeparate(params s: array of string): sequence of string := SizeSeparate(SizeSeparateType, _width, s);
    
    ///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
    public static function SizeSeparateWSpaces(params s: array of string): sequence of string := SizeSeparate(SizeSeparateType, _width - 2, s);
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
    public procedure Read(x, y: integer);
    begin
      Console.Pre;
      var s: string = '';
      while (s='') and (Console.WindowSizeIsActual) do
      begin
        Console.SetCursorPosition(x,y);write(': ');
        readln(s);
      end;
      _input:=s;
      Console.After;
    end;
    
    ///Ввод
    public procedure Read := Read(1, Console._height - 2);
    
    ///Ввод при изменении размера
    public procedure ReadWithResize(start, size: integer);
    begin
      Console.Pre;
      var s: string = '';
      while (s='') and (Console.WindowSizeIsActual) do
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
  
  ///Представляет класс позиций для KeyBlock
  StageBlock = class
    internal _min, _max: integer;
    internal _current: integer;
    
    ///Возвращает или задаёт минимально возможную позицию для текущего StageBlock
    public property Min: integer read _min write _min := value;
    
    ///Возвращает или задаёт максимально возможную позицию для текущего StageBlock
    public property Max: integer read _max write _max := value;
    
    ///Возвращает или задаёт текущую позицию для текущего StageBlock
    public property Current: integer read _current write _current := value;
    
    private constructor := exit;
    
    ///Создаёт новый экземпляр StageBlock
    public constructor(sbmin, sbmax, sbcur: integer);
    begin
      if sbmax < sbmin then raise new System.Exception;
      if not (sbcur in Range(sbmin,sbmax)) then raise new System.Exception;
      _min := sbmin;
      _max := sbmax;
      _current := sbcur;
    end;
    
    ///Создаёт новый экземпляр StageBlock, присваивая Current значение по умолчанию
    public constructor(sbmin, sbmax: integer) := Create(sbmin, sbmax, 1);
  end;
  
  KeyBlockAction = class
    public Binds: array of Key;
    public Action: System.Action;
    public constructor(a: System.Action; params b: array of Key);
    begin
      Binds := b;
      Action := a;
    end;
    public constructor(a: System.Action);
    begin
      Binds := nil;
      Action := a;
    end;
  end;
  
  KeyBlockBuilder = class;
  
  ///Представляет класс псевдоокна, который управляется клавишами
  KeyBlock = class
    ///-
    private _status: boolean;
    ///-
    private _stage: array of StageBlock;
    ///-
    private _input: System.ConsoleKeyInfo;
    ///-
    private _usekeys: array of Key;
    ///-
    private _increasers: array of Key;
    ///-
    private _decreasers: array of Key;
    ///-
    private _exiters: array of Key;
    ///-
    private _confirmers: array of Key;
    ///-
    private _actioners: array of KeyBlockAction;
    ///-
    private _stdstage: integer;
    ///-
    private _stagecheckusing: boolean;
    
    ///Состояние блока
    public property Status: boolean read _status;
    
    ///Возвращает или задаёт значение стандартной позиции
    public property CurrentStage: integer read _stage[_stdstage]._current write _stage[_stdstage]._current := value;
    
    ///Целочисленные позиции блока
    public property Stage[ind: integer]: integer read _stage[ind]._current write _stage[ind]._current := value;
    
    ///Позиции блока
    public property FullStage[ind: integer]: StageBlock read _stage[ind] write _stage[ind] := value;
    
    ///Возвращает или задаёт клавиши, которые повышают стандартную позицию
    public property Increasers[ind: integer]: Key read _increasers[ind] write _increasers[ind] := value;
    
    ///Возвращает или задаёт клавиши, которые понижают стандартную позицию
    public property Decreasers[ind: integer]: Key read _decreasers[ind] write _decreasers[ind] := value;
    
    ///Возвращает или задаёт клавиши, которые закрывают данный KeyBlock
    public property Exiters[ind: integer]: Key read _exiters[ind] write _exiters[ind] := value;
    
    ///Возвращает или задаёт клавиши, которые проводят действие
    public property Confirmers[ind: integer]: Key read _confirmers[ind] write _confirmers[ind] := value;
    
    ///Возвращает или задаёт классы KeyBlockAction
    public property Actioners[ind: integer]: KeyBlockAction read _actioners[ind] write _actioners[ind] := value;
    
    ///Задаёт новые клавиши повышения позиции
    public procedure SetIncreasers(a: array of Key) := _increasers := a;
    
    ///Задаёт новые клавиши выхода из блока
    public procedure SetExiters(a: array of Key) := _exiters := a;
    
    ///Задаёт новые клавиши действия
    public procedure SetConfirmers(a: array of Key) := _confirmers := a;
    
    ///Задаёт новые клавиши понижения позиции
    public procedure SetDecreasers(a: array of Key) := _decreasers := a;
    
    ///Задаёт новые KeyBlockAction'ы
    public procedure SetActioners(a: array of KeyBlockAction) := _actioners := a;
    
    private function _confirm: boolean;
    begin
      if _confirmers <> nil then Result := _confirmers.Contains(_input.Key);
    end;
    
    ///Возвращает true, если нажата клавиша действия
    public property Confirm: boolean read _confirm;
    
    ///Возвращает или задаёт стандартную позицию, которая будет использована повышателями и понижателями позиций
    public property StandardStage: integer read _stdstage write _stdstage := value;
    
    ///Возвращает или задаёт значение, указывающее на то, будут ли происходить проверки позиций в цикле
    public property StageChecking: boolean read _stagecheckusing write _stagecheckusing := value;
    
    ///Возвращает информацию о введённой клавише
    public property Input: System.ConsoleKeyInfo read _input;
    
    private procedure SetKeys(a: array of Key) := _usekeys := a;
    
    ///Используемые клавиши в блоке
    ///При нажатии неиспользуемых не будет обновляться консоль
    public property Keys: array of Key read _usekeys write SetKeys;
    
    ///Возвращает нажатую клавишу
    public function GetInputKey := _input.Key;
    
    ///Чтение клавиши
    ///Если передано true, то изменяет стандартную позицию
    public procedure Read(CheckReasers: boolean);
    begin
      var k := Console.ReadKey;
      
      while ((not _usekeys.Contains(k.Key)) or (_actioners.Any(x -> x.Binds <> nil ? x.Binds.Contains(k.Key) : true))) and (Console.WindowSizeIsActual) do
      begin
        if _actioners <> nil then
          foreach var x in _actioners do
            if x.Binds = nil then x.Action.Invoke else if x.Binds.Contains(k.Key) then x.Action.Invoke;
        k := Console.ReadKey;
      end;
      
      
      _input := k;
      if CheckReasers then
      begin
        if _increasers <> nil then
          if _increasers.Contains(k.Key) then _stage[_stdstage]._current += 1;
          
        if _decreasers <> nil then
          if _decreasers.Contains(k.Key) then _stage[_stdstage]._current -= 1;
          
        if _exiters <> nil then
          if _exiters.Contains(k.Key) then _status := false;
      end;
    end;
    
    ///Чтение клавиши
    public procedure Read := Read(_stagecheckusing);
    
    ///Обновляет консоль
    ///Если передано true, то также проверяет позиции текущего KeyBlock
    public procedure Reload(CheckStages: boolean);
    begin
      if CheckStages then
      for var i := 0 to _stage.Length - 1 do
      begin
        if _stage[i]._current < _stage[i]._min then _stage[i]._current := _stage[i]._max;
        if _stage[i]._current > _stage[i]._max then _stage[i]._current := _stage[i]._min;
      end;
      Console.Resize;
    end;
    
    ///Обновляет консоль
    public procedure Reload := Reload(_stagecheckusing);
    
    ///Обновляет консоль
    public procedure Update := Reload;
    
    ///Изменяет размер параметров блока
    public procedure SetSize(length: integer) := SetLength(_stage,length);
    
    ///Закрывает данный блок
    public procedure Close();
    begin
      _status := false;
    end;
    
    private constructor;
    begin
      Console.After;
      if not Console.IsInit then Console.Init;
      _status := true;
    end;
    
    ///Создаёт новый экземпляр класса KeyBlock
    public constructor(a: Func0<KeyBlock>);
    
    ///--
    public static function operator implicit(a: KeyBlock): boolean := a._status;
  end;
  
  ///Представляет строитель для класса KeyBlock
  KeyBlockBuilder = class
    private _Stages := new List<StageBlock>;
    private _StdStage: integer;
    
    private _Keys := new List<Key>;
    private _Increasers := new List<Key>;
    private _Decreasers := new List<Key>;
    private _Confirmers := new List<Key>;
    private _Exiters := new List<Key>;
    private _Actioners := new List<KeyBlockAction>;
    private _CheckStages: boolean;
    
    ///Возвращает позиции создаваемого объекта KeyBlock
    public property Stages[ind: integer]: StageBlock read _Stages[ind];
    
    ///Возвращает повышатели позиций создаваемого объекта KeyBlock
    public property Increasers[ind: integer]: Key read _Increasers[ind];
    
    ///Возвращает понижатели позиций создаваемого объекта KeyBlock
    public property Decreasers[ind: integer]: Key read _Decreasers[ind];
    
    ///Возвращает клавиши действия создаваемого объекта KeyBlock
    public property Confirmers[ind: integer]: Key read _Confirmers[ind];
    
    ///Возвращает клавиши выхода позиций создаваемого объекта KeyBlock
    public property Exiters[ind: integer]: Key read _Exiters[ind];
    
    ///Возвращает все используемые клавиши создаваемого объекта KeyBlock
    public property Keys[ind: integer]: Key read _Keys[ind];
    
    ///Возвращает или задаёт значение, которое показывает, будет ли вестись проверка позиций создаваемого объекта KeyBlock
    public property CheckStages: boolean read _CheckStages write _CheckStages := value;
    
    ///Возвращает или задаёт значение, которое показывает стандартную позицию создаваемого объекта KeyBlock
    public property StandardStage: integer read _StdStage write _StdStage := value;
    
    ///Добавляет клавишу в создаваемый объект KeyBlock
    public procedure AddKey(a: Key) := _Keys.Add(a);
    
    ///Добавляет клавиши в создаваемый объект KeyBlock
    public procedure AddKeys(a: sequence of Key) := _Keys.AddRange(a);
    
    ///Добавляет клавиши в создаваемый объект KeyBlock
    public procedure AddKeys(params a: array of Key) := AddKeys(a as IEnumerable<Key>);
    
    ///Добавляет новый KeyBlockAction в создаваемый объект KeyBlock
    public procedure AddAction(a: KeyBlockAction) := _Actioners.Add(a);
    
    ///Добавляет новый KeyBlockAction в создаваемый объект KeyBlock
    public procedure AddAction(a: System.Action) := _Actioners.Add(new KeyBlockAction(a));
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure AddAction(a: sequence of KeyBlockAction) := _Actioners.AddRange(a);
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure AddAction(a: sequence of System.Action);
    begin
      foreach var x in a do _Actioners.Add(new KeyBlockAction(x));
    end;
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure AddAction(params a: array of KeyBlockAction) := AddAction(a as IEnumerable<KeyBlockAction>);
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure AddAction(params a: array of System.Action) := AddAction(a as IEnumerable<System.Action>);
    
    ///Добавляет новый KeyBlockAction в создаваемый объект KeyBlock
    public procedure RemoveAction(a: KeyBlockAction) := _Actioners.Remove(a);
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure RemoveAction(a: sequence of KeyBlockAction) := foreach var x in a do _Actioners.Remove(x);
    
    ///Добавляет новые KeyBlockAction'ы в создаваемый объект KeyBlock
    public procedure RemoveAction(params a: array of KeyBlockAction) := AddAction(a as IEnumerable<KeyBlockAction>);
    
    ///Добавляет позицию в создаваемый объект KeyBlock
    public procedure AddStage(a: StageBlock) := _Stages.Add(a);
    
    ///Добавляет позицию в создаваемый объект KeyBlock
    public procedure AddStage(min, max, cur: integer) := _Stages.Add(new StageBlock(min, max, cur));
    
    ///Добавляет позицию в создаваемый объект KeyBlock
    public procedure AddStage(min, max: integer) := _Stages.Add(new StageBlock(min, max));
    
    ///Удаляет позицию с позиции i массива позиций из создаваемого объекта KeyBlock
    public procedure RemoveStage(i: integer) := _Stages.RemoveAt(i);
    
    ///Удаляет позицию из создаваемого объекта KeyBlock
    public procedure RemoveStage(a: StageBlock) := _Stages.Remove(a);
    
    ///Удаляет клавишу из создаваемого объекта KeyBlock
    public procedure RemoveKey(a: Key) := _Keys.Remove(a);
    
    ///Удаляет клавиши из создаваемого объекта KeyBlock
    public procedure RemoveKeys(a: sequence of Key) := foreach var x in a do _Keys.Remove(x);
    
    ///Удаляет клавиши из создаваемого объекта KeyBlock
    public procedure RemoveKeys(params a: array of Key) := RemoveKeys(a as IEnumerable<Key>);
    
    ///Добавляет клавишу, которые повышают позицию, в создаваемый объект KeyBlock
    public procedure AddIncreaser(a: Key);
    begin
      if not _Keys.Contains(a) then _Keys.Add(a);
      _Increasers.Add(a);
    end;
    
    ///Добавляет клавиши, которые повышают позицию, в создаваемый объект KeyBlock
    public procedure AddIncreasers(a: sequence of Key);
    begin
      foreach var x in a do
      begin
        if not _Keys.Contains(x) then _Keys.Add(x);
        _Increasers.Add(x);
      end;
    end;
    
    ///Добавляет клавиши, которые повышают позицию, в создаваемый объект KeyBlock
    public procedure AddIncreasers(params a: array of Key) := AddIncreasers(a as IEnumerable<Key>);
    
    ///Удаляет клавиши, которые повышают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveIncreaser(a: Key);
    begin
      RemoveKey(a);
      _Increasers.Remove(a);
    end;
    
    ///Удаляет клавиши, которые повышают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveIncreasers(a: sequence of Key) := foreach var x in a do RemoveIncreaser(x);
    
    ///Удаляет клавиши, которые повышают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveIncreasers(params a: array of Key) := RemoveIncreasers(a as IEnumerable<Key>);
    
    ///Добавляет клавишу, которые понижают позицию, в создаваемый объект KeyBlock
    public procedure AddDecreaser(a: Key);
    begin
      if not _Keys.Contains(a) then _Keys.Add(a);
      _Decreasers.Add(a);
    end;
    
    ///Добавляет клавиши, которые понижают позицию, в создаваемый объект KeyBlock
    public procedure AddDecreasers(a: sequence of Key);
    begin
      foreach var x in a do
      begin
        if not _Keys.Contains(x) then _Keys.Add(x);
        _Decreasers.Add(x);
      end;
    end;
    
    ///Добавляет клавиши, которые понижают позицию, в создаваемый объект KeyBlock
    public procedure AddDecreasers(params a: array of Key) := AddDecreasers(a as IEnumerable<Key>);
    
    ///Удаляет клавиши, которые понижают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveDecreaser(a: Key);
    begin
      RemoveKey(a);
      _Decreasers.Remove(a);
    end;
    
    ///Удаляет клавиши, которые понижают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveDecreasers(a: sequence of Key) := foreach var x in a do RemoveDecreaser(x);
    
    ///Удаляет клавиши, которые понижают позицию, из создаваемого объекта KeyBlock
    public procedure RemoveDecreasers(params a: array of Key) := RemoveDecreasers(a as IEnumerable<Key>);
    
    ///Добавляет клавишу действия в создаваемый объект KeyBlock
    public procedure AddConfirmer(a: Key);
    begin
      if not _Keys.Contains(a) then _Keys.Add(a);
      _Confirmers.Add(a);
    end;
    
    ///Добавляет клавиши действия в создаваемый объект KeyBlock
    public procedure AddConfirmers(a: sequence of Key);
    begin
      foreach var x in a do
      begin
        if not _Keys.Contains(x) then _Keys.Add(x);
        _Confirmers.Add(x);
      end;
    end;
    
    ///Добавляет клавиши действия в создаваемый объект KeyBlock
    public procedure AddConfirmers(params a: array of Key) := AddConfirmers(a as IEnumerable<Key>);
    
    ///Удаляет клавиши действия из создаваемого объекта KeyBlock
    public procedure RemoveConfirmer(a: Key);
    begin
      RemoveKey(a);
      _Confirmers.Remove(a);
    end;
    
    ///Удаляет клавиши действия из создаваемого объекта KeyBlock
    public procedure RemoveConfirmers(a: sequence of Key) := foreach var x in a do RemoveConfirmer(x);
    
    ///Удаляет клавиши действия из создаваемого объекта KeyBlock
    public procedure RemoveConfirmers(params a: array of Key) := RemoveConfirmers(a as IEnumerable<Key>);
    
    ///Добавляет клавишу выхода в создаваемый объект KeyBlock
    public procedure AddExiter(a: Key);
    begin
      if not _Keys.Contains(a) then _Keys.Add(a);
      _Exiters.Add(a);
    end;
    
    ///Добавляет клавиши выхода в создаваемый объект KeyBlock
    public procedure AddExiters(a: sequence of Key);
    begin
      foreach var x in a do
      begin
        if not _Keys.Contains(x) then _Keys.Add(x);
        _Exiters.Add(x);
      end;
    end;
    
    ///Добавляет клавиши выхода в создаваемый объект KeyBlock
    public procedure AddExiters(params a: array of Key) := AddExiters(a as IEnumerable<Key>);
    
    ///Удаляет клавиши выхода из создаваемого объекта KeyBlock
    public procedure RemoveExiter(a: Key);
    begin
      RemoveKey(a);
      _Exiters.Remove(a);
    end;
    
    ///Удаляет клавиши выхода из создаваемого объекта KeyBlock
    public procedure RemoveExiters(a: sequence of Key) := foreach var x in a do RemoveExiter(x);
    
    ///Удаляет клавиши выхода из создаваемого объекта KeyBlock
    public procedure RemoveExiters(params a: array of Key) := RemoveExiters(a as IEnumerable<Key>);
    
    ///Возвращает готовый KeyBlock
    public function ToKeyBlock: KeyBlock;
    begin
      Result := new KeyBlock;
      Result._stdstage := _StdStage;
      Result._stage := _Stages.ToArray;
      Result._usekeys := _Keys.ToArray;
      Result._decreasers := _Decreasers.ToArray;
      Result._increasers := _Increasers.ToArray;
      Result._confirmers := _Confirmers.ToArray;
      Result._exiters := _Exiters.ToArray;
      Result._stagecheckusing := _CheckStages;
    end;
    
    public static function operator implicit(a: KeyBlockBuilder): KeyBlock := a.ToKeyBlock;
    
    public constructor;
    begin
      
    end;
  end;
  
  ///Представляет готовые строители классов KeyBlock
  StandardKeyBlocksBuilders = static class
    private static function _BuildCleanKeyBlock: KeyBlockBuilder;
    begin
      Result := new KeyBlockBuilder;
      Result._CheckStages := false;
      Result._StdStage := 0;
      Result._Stages += new StageBlock(1, 1, 1);
    end;
    
    private static function _BuildKeyBlockWithExitConfirmErs: KeyBlockBuilder;
    begin
      Result := new KeyBlockBuilder;
      Result._CheckStages := false;
      Result._StdStage := 0;
      Result._Stages += new StageBlock(1, 1, 1);
      Result._Exiters += Key.Escape;
      Result._Confirmers += Key.Enter;
    end;
    
    ///Представляет чистый строитель классов KeyBlock
    ///Основа для тех случаев, когда Stage регулируются особым, отличным от внутреннего, образом
    public static property BuildCleanKeyBlock: KeyBlockBuilder read _BuildCleanKeyBlock;
    
    ///Представляет чистый строитель классов KeyBlock
    ///От BuildCleanKeyBlock отличается тем, что при нажатии Escape блок закрывается, а при нажатии Enter происходит действие
    public static property BuildKeyBlockWithExitConfirmErs: KeyBlockBuilder read _BuildKeyBlockWithExitConfirmErs;
    
    ///Возвращает полностью чистый строитель классов KeyBlock
    public static property Zero: KeyBlockBuilder read (new KeyBlockBuilder);
  end;
  
constructor KeyBlock.Create(a: Func0<KeyBlock>); 
begin 
  var k := a.Invoke;
  Self._usekeys := k._usekeys; 
  Self._decreasers := k._decreasers;
  Self._increasers := k._increasers;
  Self._confirmers := k._confirmers;
  Self._exiters := k._exiters;
  Self._stage := k._stage; 
  Self._stagecheckusing := k._stagecheckusing; 
  Self._status := k._status; 
  Self._stdstage := k._stdstage; 
  Self._actioners := k._actioners;
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
function SizeSeparate(x: integer; params s: array of string) := Console.SizeSeparate(Console.SizeSeparateType, x, s);

///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
function SizeSeparate(self: array of string; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, x, self);

///Возвращает последовательность строк, разделённых по заданной длине стандартным способом переноса
function SizeSeparate(self: string; x: integer): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, x, self);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(params s: array of string) := Console.SizeSeparate(Console.SizeSeparateType, Console._width, s);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(self: array of string): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли стандартным способом переноса
function SizeSeparate(self: string): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, Console._width, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(params s: array of string) := Console.SizeSeparate(Console.SizeSeparateType, Console._width - 2, s);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(self: array of string): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, Console._width - 2, self);

///Возвращает последовательность строк, разделённых по ширине консоли с отступами по краям стандартным способом переноса
function SizeSeparateWSpaces(self: string): sequence of string; extensionmethod := Console.SizeSeparate(Console.SizeSeparateType, Console._width - 2, self);

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
    
    //private constructor := exit;
    
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
    ///--
    v20,
    ///--
    &New,
    ///--
    Exp64,
    ///--
    Exp128,
    ///Лучший тип конвертации по передаче цветов (идеальный для градиента). Очень долгая конвартация
    Master,
    ///Эстетически лучший тип конвертации. Имеет в 4 раза меньше цветов по сравнению со всеми остальными
    Esthetic1024
  );
  
  ///Представляет клетку консоли
  DrawBox = class(IComparable<DrawBox>)
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
    
    public function CompareTo(other: DrawBox): integer;
    begin
      if (other = nil) then 
      begin
        Result := 1;
      end
      else Result := ((PosY * 100000) + PosX) - ((other.PosY * 100000) + other.PosX);
    end;
    
    //public static function Parse(s: string): DrawBox := new DrawBox(s);
    
    ///Возвращает строковое представление текущего экземпляра класса
    public function ToString: string; override;
    begin
      Result := $'({PosX},{PosY},{Back},{Fore},{Symbol})';
    end;
    
    internal static function _Equality(left, right: DrawBox): boolean;
    begin
      Result := 
        (left.PosX = right.PosX) and (left.PosY = right.PosY) and (left.Back = right.Back) and (left.Fore = right.Fore) and (left.Symbol = right.Symbol);
    end;
  end;
  
  ColorBox = record
    public R, G, B: integer;
    public Back, Fore: Color;
    public Symbol: char;
    
    public function ToDrawBox(x, y: integer): DrawBox;
    begin
      Result := new DrawBox();
      Result.PosX := x;
      Result.PosY := y;
      Result.Back := Back;
      Result.Fore := Fore;
      Result.Symbol := Symbol;
    end;
  end;
  
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
        Master, Esthetic1024: Result := FromRGB(r, g, b);
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
    
    public static MasterColors: array of ColorBox;
    public static Esthetic1024Colors: array of ColorBox;
    
    public static function GetARGB(c: Color): System.ValueTuple<byte, byte, byte>;
    begin
      case c of
        Color.Black: Result := new System.ValueTuple<byte, byte, byte>(0,0,0);
        Color.DarkGray: Result := new System.ValueTuple<byte, byte, byte>(128,128,128);
        Color.Gray: Result := new System.ValueTuple<byte, byte, byte>(192,192,192);
        Color.White: Result := new System.ValueTuple<byte, byte, byte>(255,255,255);
        Color.DarkBlue: Result := new System.ValueTuple<byte, byte, byte>(0,0,128);
        Color.DarkGreen: Result := new System.ValueTuple<byte, byte, byte>(0,128,0);
        Color.DarkRed: Result := new System.ValueTuple<byte, byte, byte>(128,0,0);
        Color.DarkCyan: Result := new System.ValueTuple<byte, byte, byte>(0,128,128);
        Color.DarkYellow: Result := new System.ValueTuple<byte, byte, byte>(128,128,0);
        Color.DarkMagenta: Result := new System.ValueTuple<byte, byte, byte>(128,0,128);
        Color.Blue: Result := new System.ValueTuple<byte, byte, byte>(0,0,255);
        Color.Green: Result := new System.ValueTuple<byte, byte, byte>(0,255,0);
        Color.Red: Result := new System.ValueTuple<byte, byte, byte>(255,0,0);
        Color.Cyan: Result := new System.ValueTuple<byte, byte, byte>(0,255,255);
        Color.Yellow: Result := new System.ValueTuple<byte, byte, byte>(255,255,0);
        Color.Magenta: Result := new System.ValueTuple<byte, byte, byte>(255,0,255);
      end;
    end;
    
    public static function Mix(a, b: Color; mixing: real): System.ValueTuple<byte, byte, byte>;
    begin
      var left := GetARGB(a);
      var right := GetARGB(b);
      Result := new System.ValueTuple<byte, byte, byte>(
        Round(left.Item1 + (right.Item1-left.Item1)*mixing),
        Round(left.Item2 + (right.Item2-left.Item2)*mixing),
        Round(left.Item3 + (right.Item3-left.Item3)*mixing)
      );
    end;
    
    public static function FillColors(context: Dictionary<char, single>): array of ColorBox;
    begin
      //Result := new ColorBox[(16*16)*context.Count];
      var lst := new List<ColorBox>(16 * 16 * context.Count);
      for var i := 0 to 15 do
      begin
        var current := new ColorBox();
        current.Symbol := ' ';
        current.Back := Color(i);
        current.Fore := Color.Black;
        var gc := GetARGB(current.Back);
        current.R := gc.Item1;
        current.G := gc.Item2;
        current.B := gc.Item3;
        lst.Add(current);
      end;
      
      for var i := 0 to 15 do
      begin
        for var j := 0 to 15 do
        begin
          if (i = j) then continue;
          foreach var x in context do
          begin
            var current := new ColorBox();
            current.Back := Color(j);
            current.Fore := Color(i);
            current.Symbol := x.Key;
            var mx := Mix(current.Back, current.Fore, x.Value);
            current.R := mx.Item1;
            current.G := mx.Item2;
            current.B := mx.Item3;
            if (not lst.Any(x -> (x.R - current.R)**2 + (x.G - current.G)**2 + (x.B - current.B)**2 = 0)) then lst.Add(current);
            //Result[cnt] := current;
            //cnt += 1;
          end;
        end;
      end;
      Result := lst.ToArray();
    end;
    
    static constructor;
    begin
      var MasterContext: Dictionary<char, single> := new Dictionary<char, single>();
      //MasterContext.Add(' ', 0);
      MasterContext.Add('.', 0.06);
      MasterContext.Add(':', 0.13);
      //MasterContext.Add(';', 0.16);
      MasterContext.Add('%', 0.21);
      MasterContext.Add('t', 0.29);
      //MasterContext.Add('S', 0.32);
      MasterContext.Add('░', 0.33);
      //MasterContext.Add('X', 0.35);
      MasterContext.Add('8', 0.4);
      //MasterContext.Add('&', 0.41);
      //MasterContext.Add('@', 0.42);
      MasterContext.Add('#', 0.44);
      MasterContext.Add('▒', 0.5);
      MasterContext.Add('▓', 0.66);
      MasterColors := FillColors(MasterContext);
      
      var EstheticContext: Dictionary<char, single> := new Dictionary<char, single>();
      //EstheticContext.Add(' ', 0);
      EstheticContext.Add('░', 0.33);
      EstheticContext.Add('▒', 0.5);
      EstheticContext.Add('▓', 0.66);
      Esthetic1024Colors := FillColors(EstheticContext);
    end;
    
    public static function Find(colors: array of ColorBox; r, g, b: byte): ColorBox;
    begin
      var absi: integer;
      var abssum := (colors[0].R - r)**2 + (colors[0].G - g)**2 + (colors[0].B - b)**2;
      for var i := 1 to colors.Length - 1 do
      begin
        var currentabssum := (colors[i].R - r)**2 + (colors[i].G - g)**2 + (colors[i].B - b)**2;
        if (currentabssum < abssum) then
        begin
          absi := i;
          abssum := currentabssum;
          if (abssum < 2) then break;
        end;
      end;
      Result := colors[absi];
    end;
    
    public static function Find(converttype: RGBToColorConvertType; r, g, b: byte): ColorBox;
    begin
      case converttype of
        RGBToColorConvertType.Master: Result := Find(MasterColors, r, g, b);
        RGBToColorConvertType.Esthetic1024: Result := Find(Esthetic1024Colors, r, g, b);
      end;
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
    ///Возвращает наличие бэкграунда у блока
    public BackgroundAvailable: boolean;
    ///Массив клеток консоли
    public Draws: array of DrawBox;
    
    internal constructor := exit;
    
    ///Создаёт новый экземпляр клссса DrawBoxBlock
    public constructor (x, y: integer; b: Color; arr: array of DrawBox);
    begin
      SizeX:=x;
      SizeY:=y;
      Background:=b;
      BackgroundAvailable := true;
      Draws:=arr;
    end;
    
    ///Создаёт новый экземпляр класса DrawBoxBlock, загружая его из файла name
    public constructor (name: string);
    begin
      var f: file;
      reset(f,name);
      Read(f,SizeX);
      Read(f,SizeY);
      var a1: byte;
      var a2: integer;
      Read(f,a1);
      Read(f, BackgroundAvailable);
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
    
    ///Создаёт новый экземпляр класса DrawBoxBlock, вытаскивая его из ресурсного файла с именем name
    public static function FromResourceStream(name: string): DrawBoxBlock;
    begin
      var br := new System.IO.BinaryReader(GetResourceStream(name));
      var sx, sy: integer;
      var a1: byte;
      var a2: integer;
      var bav := false;
      
      sx := br.ReadInt32;
      sy := br.ReadInt32;
      a1 := br.ReadByte;
      bav := br.ReadBoolean;
      a2 := br.ReadInt32;
      var a3 := new DrawBox[a2];
      for var i:=0 to a3.Length-1 do
      begin
        var x, y: integer;
        var c: char;
        var b, f: byte;
        x := br.ReadInt32;
        y := br.ReadInt32;
        c := br.ReadChar;
        b := br.ReadByte;
        f := br.ReadByte;
        a3[i] := new DrawBox(x, y, c, ConvertColor.IntToColor(b), ConvertColor.IntToColor(f));
      end;
      Result := new DrawBoxBlock;
      Result.Background := ConvertColor.IntToColor(a1);
      Result.SizeX := sx;
      Result.SizeY := sy;
      Result.Draws := a3;
      br.Close;
      br.Dispose;
    end;
    
    ///Сохраняет текущий экземпляр класса DrawBoxBlock в файл name
    public procedure WriteKTXFile(name: string);
    begin
      var f: file;
      rewrite(f,name);
      f.Write(SizeX);
      f.Write(SizeY);
      f.Write(ConvertColor.ColorToInt(Background));
      f.Write(BackgroundAvailable);
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
    
    private static _RGBConvertingType: RGBToColorConvertType := RGBToColorConvertType.Master;
    private static _DefaultAlignmentType: DrawingAlignmentType := DrawingAlignmentType.Center;
    private static _DefaultIsOverlay := false;
    private static _DefaultDrawingType: DrawingType := DrawingType.Aline;
    
    ///Возвращает или задаёт стандартную конвертацию цвета
    public static property RGBConvertingType: RGBToColorConvertType read _RGBConvertingType write _RGBConvertingType := value;
    
    ///Возвращает или задаёт стандартную отцентровку рисунка
    public static property DefaultAlignmentType: DrawingAlignmentType read _DefaultAlignmentType write _DefaultAlignmentType := value;
    
    ///Возвращает или задаёт стандартный параметр наложения
    public static property DefaultIsOverlay: boolean read _DefaultIsOverlay write _DefaultIsOverlay := value;
    
    ///Возвращает или задаёт стандартный тип рисования
    public static property DefaultDrawingType: DrawingType read _DefaultDrawingType write _DefaultDrawingType := value;
    
    ///Преобразует ARGB (4 байтовое) представление цвета в DrawBox
    public static function ARGBPixelToDrawBox(converttype: RGBToColorConvertType; x, y: integer; bga: boolean; bg: Color; a, r, g, b: byte): DrawBox;
    begin
      if (converttype < RGBToColorConvertType.Master) then
      begin
        Result := new DrawBox();
        Result.PosX := x;
        Result.PosY := y;
        Result.Symbol:=' ';
        Result.Back:=RGBConsole.RGBToColor(converttype,r,g,b);
        
        var RR, GG, BB: integer;
        
        (RR, GG, BB) := RGBConsole.RGBToSubColor(converttype, Result.Back, r, g, b);
        
        Result.Fore := RGBConsole.RGBToColor(converttype, RR*16, GG*16, BB*16);
        Result.Symbol := Context[Arr(RR, GG, BB).Average.Round];
      end
      else
      begin
        if (bga) and RGBConsole.ColorEquality(bg,r,g,b) then Result := nil
        else
        begin
          var fnd := RGBConsole.Find(converttype, r, g, b);
          Result := fnd.ToDrawBox(x, y);
        end;
      end;
      
    end;
    
    ///Преобразует файл-рисунок в экземпляр класса DrawBoxBlock используя переданный тип конвертации
    public static function BitMapToDrawBoxBlock(converttype: RGBToColorConvertType; bmpname: string): DrawBoxBlock;
    begin
      var Draws := new List<DrawBox>;
      var locker := new object;
      var b := new Bitmap(bmpname);
      
      Result := new DrawBoxBlock();
      Result.SizeX := b.Width;
      Result.SizeY := b.Height;
      
      var width := b.Width;
      
      var rect := new Rectangle(0, 0, Result.SizeX, Result.SizeY);
      var bdata := b.LockBits(rect, System.Drawing.Imaging.ImageLockMode.ReadWrite, b.PixelFormat);
      var ptr := bdata.Scan0;
      var bytes := System.Math.Abs(bdata.Stride) * Result.SizeY;
      var argbValues := new byte[bytes];
      var socolors := new List<System.ValueTuple<System.Drawing.Color, integer, integer>>;
      
      System.Runtime.InteropServices.Marshal.Copy(ptr, argbValues, 0, bytes);
      b.UnlockBits(bdata);
      
      var bga := true;
      
      if (b.PixelFormat = System.Drawing.Imaging.PixelFormat.Format24bppRgb) then
      begin
        // непонятные смещения для Format24bppRgb, поэтому возвращаю костыль, но только для 24bpp
        for var i := 0 to width - 1 do
          for var j := 0 to b.Height - 1 do
          begin
            socolors += new System.ValueTuple<System.Drawing.Color, integer, integer>(b.GetPixel(i, j), i, j); 
          end;
          
//        Parallel.For(0, (argbValues.Length - 1) div 3, i ->
//        begin
//          var xx := i mod width;
//          var yy := i div width;
//          var currentcolor := System.Drawing.Color.FromArgb(argbValues[i * 3 + 2], argbValues[i * 3 + 1], argbValues[i * 3]);
//          lock (locker) do socolors += new System.ValueTuple<System.Drawing.Color, integer, integer>(currentcolor, xx, yy);
//        end);
      end
      else if (b.PixelFormat = System.Drawing.Imaging.PixelFormat.Format32bppArgb) then
      begin
        Parallel.For(0, (argbValues.Length - 1) div 4, i ->
        begin
          var xx := i mod width;
          var yy := i div width;
          var currentcolor := System.Drawing.Color.FromArgb(argbValues[i * 4 + 3], argbValues[i * 4 + 2], argbValues[i * 4 + 1], argbValues[i * 4]);
          if (currentcolor.A = 0) then
          begin
            bga := false;
            exit;
          end;
          lock (locker) do socolors += new System.ValueTuple<System.Drawing.Color, integer, integer>(currentcolor, xx, yy);
        end);
      end;
      
      if (bga) then
      begin
        Result.BackgroundAvailable := true;
        var bgrnd0 := System.Drawing.Color.FromArgb(socolors.Select(x -> x.Item1).GroupBy(x -> x.ToArgb).MaxBy(x -> x.Count).Key);
        Result.Background := RGBConsole.RGBToColor(converttype, bgrnd0.R, bgrnd0.G, bgrnd0.B);
      end;
      
      var bgrnd := Result.Background; //issue #2136
      
      Parallel.For(0, socolors.Count - 2, i ->
      begin
        var dbx := ARGBPixelToDrawBox(converttype, socolors[i].Item2, socolors[i].Item3, bga, bgrnd, socolors[i].Item1.A, socolors[i].Item1.R, socolors[i].Item1.G, socolors[i].Item1.B);
        if (dbx = nil) then exit;
        lock (locker) do Draws.Add(dbx);
      end);
      Draws.Sort();
      
      Result.Draws := Draws.ToArray;
      
      b.Dispose;
    end;
    
    ///Преобразует файл-рисунок в экземпляр класса DrawBoxBlock
    public static function BitMapToDrawBoxBlock(bmpname: string): DrawBoxBlock := BitMapToDrawBoxBlock(_RGBConvertingType, bmpname);
    
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
        Up: Result := ((System.Console.BufferWidth - a.SizeX) div 2, 0);
        RightUp: Result := ((System.Console.BufferWidth - a.SizeX), 0);
        
        Left: Result := (0, (System.Console.BufferHeight - a.SizeY) div 2);
        Center: Result := ((System.Console.BufferWidth - a.SizeX) div 2,(System.Console.BufferHeight -  a.SizeY) div 2);
        Right: Result := ((System.Console.BufferWidth - a.SizeX), (System.Console.BufferHeight - a.SizeY) div 2);
        
        LeftDown: Result := (0, (System.Console.BufferHeight - a.SizeY));
        Down: Result := ((System.Console.BufferWidth - a.SizeX) div 2, (System.Console.BufferHeight - a.SizeY));
        RightDown: Result := ((System.Console.BufferWidth - a.SizeX), (System.Console.BufferHeight - a.SizeY));
      end;
    end;
    
    ///Возвращает позицию в консоли левого верхнего угла картинки с учётом стандартного центрирования
    public static function GetStartPos(a: DrawBoxBlock) := GetStartPos(a, _DefaultAlignmentType);
    
    ///Построчное рисование a от позиции (x, y) и параметром наложения isoverlay
    public static procedure AlineDraw(a: DrawBoxBlock; x, y: integer; isoverlay: boolean);
    begin
      System.Console.BackgroundColor := a.BackgroundAvailable ? a.Background : Color.White;
      if not isoverlay then Console.Clear;
      var lastwdh := 0;
      var lasthgt := 0;
      var lastbck := Color.White;
      var lastfore := Color.Black;
      for var i:=0 to a.Draws.Length-1 do
      begin
        var currentwidth := a.Draws[i].PosX+x;
        var currentheight := a.Draws[i].PosY+y;
        if ((lastwdh + 1 <> currentwidth) or (lasthgt <> currentheight)) then Console.SetCursorPosition(currentwidth, currentheight);
        lastwdh := currentwidth;
        lasthgt := currentheight;
        if (lastbck <> a.Draws[i].Back) then System.Console.BackgroundColor:=a.Draws[i].Back;
        if (lastfore <> a.Draws[i].Fore) then System.Console.ForegroundColor:=a.Draws[i].Fore;
        lastbck := a.Draws[i].Back;
        lastfore := a.Draws[i].Fore;
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
      System.Console.BackgroundColor := a.BackgroundAvailable ? a.Background : Color.White;
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
  if (self.SizeX > Console.MaxWidth) xor (self.SizeY > Console.MaxHeight) then
  begin
    if (self.SizeX > Console.MaxWidth) then
    begin
      Console.SetWindowSize(1, 1);
      Console.SetBufferSize(self.SizeX, self.SizeY);
      Console.SetWindowSize(Console.MaxWidth, self.SizeY);
    end
    else if (self.SizeY > Console.MaxHeight) then
    begin
      Console.SetWindowSize(1, 1);
      Console.SetBufferSize(self.SizeX, self.SizeY);
      Console.SetWindowSize(self.SizeX, Console.MaxHeight);
    end;
  end
  else
  if (self.SizeX > Console.MaxWidth) or (self.SizeY > Console.MaxHeight) then
  begin
    Console.SetWindowSize(1, 1);
    Console.SetBufferSize(self.SizeX, self.SizeY);
    Console.SetWindowSize(Console.MaxWidth, Console.MaxHeight);
  end
  else Console.SetSize(self.SizeX, self.SizeY);
end;
function SetSize(self: string): DrawBoxBlock; extensionmethod := Drawing.BitMapToDrawBoxBlock(self).SetSize;
function SetSize(self: string; ct: RGBToColorConvertType): DrawBoxBlock; extensionmethod := Drawing.BitMapToDrawBoxBlock(ct, self).SetSize;

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

procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; x, y: integer; isoverlay: boolean) := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), dt, x, y, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Dt, x.Item1, x.Item2, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; x: (integer, integer)); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Dt, x, Drawing._DefaultIsOverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; x, y: integer); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Dt, x, y, Drawing._DefaultIsOverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(ct, self).SetSize();
  Drawing.Draw(dbx, Dt, Drawing.GetStartPos(dbx,At),isoverlay);
end;
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; At: DrawingAlignmentType); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(ct, self).SetSize();
  Drawing.Draw(dbx, Dt, Drawing.GetStartPos(dbx, At), Drawing._DefaultIsOverlay);
end;
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Dt, Drawing._DefaultAlignmentType, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; Dt: DrawingType); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Dt, Drawing._DefaultIsOverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; x, y: integer; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, x, y, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, x.Item1, x.Item2, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; x: (integer, integer)); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, x, Drawing._DefaultIsOverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; x, y: integer); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, x, y, Drawing._DefaultIsOverlay);
procedure Draw(self: string; ct: RGBToColorConvertType; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(ct, self).SetSize();
  Drawing.Draw(dbx, Drawing._DefaultDrawingType, Drawing.GetStartPos(dbx,At),isoverlay);
end;
procedure Draw(self: string; ct: RGBToColorConvertType; At: DrawingAlignmentType); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(ct, self).SetSize();
  Drawing.Draw(dbx, Drawing._DefaultDrawingType, Drawing.GetStartPos(dbx,At), Drawing._DefaultIsOverlay);
end;
procedure Draw(self: string; ct: RGBToColorConvertType; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, Drawing._DefaultAlignmentType, isoverlay);
procedure Draw(self: string; ct: RGBToColorConvertType); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(ct, self).SetSize(), Drawing._DefaultDrawingType, Drawing._DefaultIsOverlay);

procedure Draw(self: string; Dt: DrawingType; x, y: integer; isoverlay: boolean) := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), dt, x, y, isoverlay);
procedure Draw(self: string; Dt: DrawingType; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Dt, x.Item1, x.Item2, isoverlay);
procedure Draw(self: string; Dt: DrawingType; x: (integer, integer)); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Dt, x, Drawing._DefaultIsOverlay);
procedure Draw(self: string; Dt: DrawingType; x, y: integer); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Dt, x, y, Drawing._DefaultIsOverlay);
procedure Draw(self: string; Dt: DrawingType; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(self).SetSize();
  Drawing.Draw(dbx, Dt, Drawing.GetStartPos(dbx,At),isoverlay);
end;
procedure Draw(self: string; Dt: DrawingType; At: DrawingAlignmentType); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(self).SetSize();
  Drawing.Draw(dbx, Dt, Drawing.GetStartPos(dbx, At), Drawing._DefaultIsOverlay);
end;
procedure Draw(self: string; Dt: DrawingType; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Dt, Drawing._DefaultAlignmentType, isoverlay);
procedure Draw(self: string; Dt: DrawingType); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Dt, Drawing._DefaultIsOverlay);
procedure Draw(self: string; x, y: integer; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, x, y, isoverlay);
procedure Draw(self: string; x: (integer, integer); isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, x.Item1, x.Item2, isoverlay);
procedure Draw(self: string; x: (integer, integer)); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, x, Drawing._DefaultIsOverlay);
procedure Draw(self: string; x, y: integer); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, x, y, Drawing._DefaultIsOverlay);
procedure Draw(self: string; At: DrawingAlignmentType; isoverlay: boolean); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(self).SetSize();
  Drawing.Draw(dbx, Drawing._DefaultDrawingType, Drawing.GetStartPos(dbx,At),isoverlay);
end;
procedure Draw(self: string; At: DrawingAlignmentType); extensionmethod;
begin
  var dbx := Drawing.BitMapToDrawBoxBlock(self).SetSize();
  Drawing.Draw(dbx, Drawing._DefaultDrawingType, Drawing.GetStartPos(dbx,At), Drawing._DefaultIsOverlay);
end;
procedure Draw(self: string; isoverlay: boolean); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, Drawing._DefaultAlignmentType, isoverlay);
procedure Draw(self: string); extensionmethod := Drawing.Draw(Drawing.BitMapToDrawBoxBlock(self).SetSize(), Drawing._DefaultDrawingType, Drawing._DefaultIsOverlay);


type
  ///Представляет методы для вывода последовательностей DrawBoxBlock'ов
  Player = static class
    //todo не работает
    private static function GetSynchronizedDBBArray(a: array of DrawBoxBlock): array of DrawBoxBlock;
    begin
      var RealDBBs := new List<DrawBoxBlock>;
      RealDBBs+=a[0];
      var Current := new List<DrawBox>;
      for var i := 1 to a.Length-1 do
      begin
        foreach var x in RealDBBs do
          foreach var y in x.Draws do Current+=y;
        foreach var x in a[i].Draws do Current+=x;
        RealDBBs+=new DrawBoxBlock(a[0].SizeX, a[0].SizeY, a[0].Background, Current.Distinct.ToArray);
        Current.Clear;
      end;
      Result := RealDBBs.ToArray;
    end;
    ///Выводит на экран поселедовательность DrawBoxBlock'ов
    public static procedure Play(params a: array of DrawBoxBlock);
    begin
      a.First.SetSize;
      foreach var x in a do x.Draw();
    end;
    ///Выводит на экран поселедовательность синхронизированных последовательностей DrawBoxBlock'ов
    ///После прохода по ячейке внешнего массива очищается экран
    public static procedure Play(t: integer; k: DrawingType; params a: array of array of DrawBoxBlock);
    begin
      a.First.First.SetSize;
      var b: array of array of DrawBoxBlock;
      SetLength(b,a.Length);
      for var i := 0 to a.Length - 1 do
      begin
        b[i] := GetSynchronizedDBBArray(a[i]);
      end;
      
      foreach var x in b do
      begin
        foreach var y in x do
        begin
          y.Draw(k, true);
          sleep(t);
        end;
        Console.RealBack := x.First.Background;
        Console.Clear;
      end;
    end;
  end;
{$endregion Drawing}
  
begin
  
end.