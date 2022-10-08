program KTXRunner;

{$title KTXRunner}

uses KTX;
uses System;
uses System.Collections.Generic;
uses System.Reflection;
  
function ToEnum<T>(self: string; ignorecase: boolean := true): T; extensionmethod; where T: System.Enum;
begin
  Result := T(Enum.Parse(typeof(T), self, ignorecase));
end;

function ToArgs(self: string); extensionmethod := new string[]('/' + self, '-' + self);

type
  KTXRunnerContext = class;
  
  KTXArgumentAttribute = class(Attribute)
    public auto property ArgumentKey: string;
    public auto property Description: string;
    public auto property &Default: string;
    
    public constructor(k, d, df: string) := (ArgumentKey, Description, &Default) := (k, d, df);
  end;
  
  KTXRunnerContext = class
    public auto property Path: string;
    public auto property IsOverlay: boolean;
    public auto property DrawingType: KTX.DrawingType;
    public auto property RGBToColorConvertType: KTX.RGBToColorConvertType;
    public auto property DrawingAlignmentType: KTX.DrawingAlignmentType;
    
    public constructor(path: string) := self.Path := path;
    
    public procedure Collect(context: KTXRunnerContext); virtual := exit;
    
    public procedure CollectArguments(args: IEnumerable<KeyValuePair<string, string>>);
    begin
      foreach var t in ArgTypes do
      begin
        var arg := t.Item2.Default;
        foreach var pair in args do
          if t.Item2.ArgumentKey.ToArgs().Contains(pair.Key) then arg := pair.Value;
        KTXRunnerContext(t.Item1.GetConstructors().Last().Invoke(new object[1](arg))).Collect(self);
      end;
    end;
    
    public procedure Run() := Path.Draw(RGBToColorConvertType, DrawingType, DrawingAlignmentType, IsOverlay);
    
    public static auto property ArgTypes: List<(&Type, KTXArgumentAttribute)>;
    static constructor();
    begin
      ArgTypes := Assembly.GetExecutingAssembly().GetTypes()
      .Where(t -> t.GetCustomAttributes().Any(x -> x.GetType() = typeof(KTXArgumentAttribute)))
      .Select(x -> (x, x.GetCustomAttribute(typeof(KTXArgumentAttribute)) as KTXArgumentAttribute)).ToList();
    end;
  end;
  
  [KTXArgumentAttribute('o', 'overlaying image (boolean)', 'false')]
  IsOverlayArg = class(KTXRunnerContext)
    public constructor(s: string) := IsOverlay := boolean.Parse(s);
    public procedure Collect(context: KTXRunnerContext); override := context.IsOverlay := IsOverlay;
  end;
  
  [KTXArgumentAttribute('d', 'drawing type (aline/hex)', 'aline')]
  DrawingTypeArg = class(KTXRunnerContext)
    public constructor(s: string) := DrawingType := s.ToEnum&<KTX.DrawingType>();
    public procedure Collect(context: KTXRunnerContext); override := context.DrawingType := DrawingType;
  end;
  
  [KTXArgumentAttribute('c', 'convert type (master, esthetic1024, v20, new)', 'master')]
  RGBToColorConvertTypeArg = class(KTXRunnerContext)
    public constructor(s: string) := RGBToColorConvertType := s.ToEnum&<KTX.RGBToColorConvertType>();
    public procedure Collect(context: KTXRunnerContext); override := context.RGBToColorConvertType := RGBToColorConvertType;
  end;
  
  [KTXArgumentAttribute('a', 'alignment (center, up, down, left, right, leftdown, rightup...)', 'center')]
  DrawingAlignmentTypeArg = class(KTXRunnerContext)
    public constructor(s: string) := DrawingAlignmentType := s.ToEnum&<KTX.DrawingAlignmentType>();
    public procedure Collect(context: KTXRunnerContext); override := context.DrawingAlignmentType := DrawingAlignmentType;
  end;

begin
  var args := System.Environment.GetCommandLineArgs();
  if (args.Length < 2) or args.Contains('[RUNMODE]') then
  begin
    Console.WriteLine('This is console application! Run it with cmd!'+NewLine);
    Console.WriteLine('First argument - path to png file'+NewLine+'Other keys:');
    foreach var arg in KTXRunnerContext.ArgTypes.Select(x -> x.Item2) do
      Console.WriteLine($'/{arg.ArgumentKey} --- {arg.Description}');
    Console.ReadLine();
    exit;
  end;
  
  var runner := new KTXRunnerContext(args[1]);
  runner.CollectArguments(args.Skip(2).Batch(2, en -> new KeyValuePair<string, string>(en.First(), en.Skip(1).First())));
  runner.Run();
  
  Console.CursorVisible := false;
  Console.ReadLine();
end.