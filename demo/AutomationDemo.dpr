{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015-16 JHC Systems Limited                              }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}
program AutomationDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  generics.collections,
  System.SysUtils,
  System.Types,
  DelphiUIAutomation.Automation in '..\source\DelphiUIAutomation.Automation.pas',
  DelphiUIAutomation.Base in '..\source\DelphiUIAutomation.Base.pas',
  DelphiUIAutomation.Client in '..\source\DelphiUIAutomation.Client.pas',
  DelphiUIAutomation.Clipboard in '..\source\DelphiUIAutomation.Clipboard.pas',
  DelphiUIAutomation.Exception in '..\source\DelphiUIAutomation.Exception.pas',
  DelphiUIAutomation.Keyboard in '..\source\DelphiUIAutomation.Keyboard.pas',
  DelphiUIAutomation.Mouse in '..\source\DelphiUIAutomation.Mouse.pas',
  DelphiUIAutomation.Processes in '..\source\DelphiUIAutomation.Processes.pas',
  DelphiUIAutomation.ScreenShot in '..\source\DelphiUIAutomation.ScreenShot.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.AndCondition in '..\source\Conditions\DelphiUIAutomation.AndCondition.pas',
  DelphiUIAutomation.Condition in '..\source\Conditions\DelphiUIAutomation.Condition.pas',
  DelphiUIAutomation.ControlTypeCondition in '..\source\Conditions\DelphiUIAutomation.ControlTypeCondition.pas',
  DelphiUIAutomation.FalseCondition in '..\source\Conditions\DelphiUIAutomation.FalseCondition.pas',
  DelphiUIAutomation.NameCondition in '..\source\Conditions\DelphiUIAutomation.NameCondition.pas',
  DelphiUIAutomation.OrCondition in '..\source\Conditions\DelphiUIAutomation.OrCondition.pas',
  DelphiUIAutomation.TrueCondition in '..\source\Conditions\DelphiUIAutomation.TrueCondition.pas',
  DelphiUIAutomation.Button in '..\source\Controls\DelphiUIAutomation.Button.pas',
  DelphiUIAutomation.Checkbox in '..\source\Controls\DelphiUIAutomation.Checkbox.pas',
  DelphiUIAutomation.ComboBox in '..\source\Controls\DelphiUIAutomation.ComboBox.pas',
  DelphiUIAutomation.Container.Intf in '..\source\controls\DelphiUIAutomation.Container.Intf.pas',
  DelphiUIAutomation.Container in '..\source\Controls\DelphiUIAutomation.Container.pas',
  DelphiUIAutomation.Desktop in '..\source\controls\DelphiUIAutomation.Desktop.pas',
  DelphiUIAutomation.EditBox in '..\source\Controls\DelphiUIAutomation.EditBox.pas',
  DelphiUIAutomation.Hyperlink in '..\source\Controls\DelphiUIAutomation.Hyperlink.pas',
  DelphiUIAutomation.ListItem in '..\source\Controls\DelphiUIAutomation.ListItem.pas',
  DelphiUIAutomation.Panel.Intf in '..\source\Controls\DelphiUIAutomation.Panel.Intf.pas',
  DelphiUIAutomation.Panel in '..\source\Controls\DelphiUIAutomation.Panel.pas',
  DelphiUIAutomation.RadioButton in '..\source\Controls\DelphiUIAutomation.RadioButton.pas',
  DelphiUIAutomation.Statusbar in '..\source\Controls\DelphiUIAutomation.Statusbar.pas',
  DelphiUIAutomation.StringGrid in '..\source\Controls\DelphiUIAutomation.StringGrid.pas',
  DelphiUIAutomation.StringGridItem in '..\source\Controls\DelphiUIAutomation.StringGridItem.pas',
  DelphiUIAutomation.Tab.Intf in '..\source\Controls\DelphiUIAutomation.Tab.Intf.pas',
  DelphiUIAutomation.Tab in '..\source\Controls\DelphiUIAutomation.Tab.pas',
  DelphiUIAutomation.TabItem in '..\source\Controls\DelphiUIAutomation.TabItem.pas',
  DelphiUIAutomation.TextBox in '..\source\Controls\DelphiUIAutomation.TextBox.pas',
  DelphiUIAutomation.ControlTypeIDs in '..\source\Ids\DelphiUIAutomation.ControlTypeIDs.pas',
  DelphiUIAutomation.PatternIDs in '..\source\Ids\DelphiUIAutomation.PatternIDs.pas',
  DelphiUIAutomation.PropertyIDs in '..\source\Ids\DelphiUIAutomation.PropertyIDs.pas',
  DelphiUIAutomation.Menu in '..\source\Controls\Menus\DelphiUIAutomation.Menu.pas',
  DelphiUIAutomation.MenuItem in '..\source\Controls\Menus\DelphiUIAutomation.MenuItem.pas',
  DelphiUIAutomation.Window in '..\source\Controls\DelphiUIAutomation.Window.pas',
  DelphiUIAutomation.TreeView in '..\source\Controls\DelphiUIAutomation.TreeView.pas';

var
  application: IAutomationApplication;
  enquiry : IAutomationWindow;
  tb1, tb2 : IAutomationEditBox;
  eb0: IAutomationTextBox;
  Tab: IAutomationTab;
  Statusbar: IAutomationStatusBar;
  check: IAutomationCheckBox;
  radio: IAutomationRadioButton;
//  eb2 : IAutomationEditBox;
  cb1: IAutomationCombobox;
  cb2: IAutomationCombobox;
  tv1: IAutomationTreeView;
  tvi: IAutomationTreeViewItem;
  exit1: IAutomationMenuItem;
  menu: IAutomationMenu;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  TUIAuto.CreateUIAuto;

  // First launch the application
  application := TAutomationApplication.LaunchOrAttach
    ('..\..\democlient\Win32\Debug\Project1.exe', '');

  application.WaitWhileBusy;

  // Now wait for a very long time for the enquiry screen to come up
  enquiry := TAutomationDesktop.GetDesktopWindow('Form1');
  enquiry.Focus;

  // Select the correct tab
  Tab := enquiry.GetTabByIndex(0);
  Tab.SelectTabPage('Second Tab'); // 3 is the magic number

  tb1 := Tab.GetEditBoxByIndex(0);
  writeln(tb1.Text);

  tb2 := enquiry.GetEditBoxByName('AutomatedEdit1');
  writeln(tb2.Text);

  check := enquiry.GetCheckboxByIndex(0);
  check.toggle;

  radio := enquiry.GetRadioButtonByIndex(2);
  radio.Select;

  // Now see whether we can get the statusbar
  Statusbar := enquiry.Statusbar;
  eb0 := Statusbar.GetTextBoxByIndex(1);
  writeln('Text is ' + eb0.Text);

  // Now get and set the text in an editbox, by name
  cb1 := enquiry.GetComboboxByName('AutomatedCombobox1');
  writeln('Combo text is ' + cb1.Text);
  cb1.Text := 'Replacements';
  cb1 := enquiry.GetComboboxByName('AutomatedCombobox1');
  writeln('Combo text is ' + cb1.Text);

  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);
  cb2.Text := 'First';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);
  cb2.Text := 'No there';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);

  cb2.Text := 'Third';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);

  // Now try and get stuff from TreeView
  tv1 := enquiry.getTreeViewByIndex(0);
  tvi := tv1.GetItem('Sub-SubItem');
  tvi.select;

  menu := enquiry.GetMainMenu;
  exit1 := menu.MenuItem('File|Exit');

  if assigned(exit1) then
    exit1.Click;

  WriteLn('Press key to exit');
  ReadLn;

  application.Kill;
end.
