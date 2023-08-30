object WM: TWM
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WMDefaultHandlerAction
    end>
  Height = 230
  Width = 415
  PixelsPerInch = 96
end
