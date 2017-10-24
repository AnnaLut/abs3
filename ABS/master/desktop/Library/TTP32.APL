Application Description: * Pivato Consulting, inc.
		* XSal - eXtended Sal
		*
		* File name     : XSalTtp_32.APL
		* Description	: XSalTooltip
		* Author	: Gianluca Pivato
		
		Copyright © 1998-2000 by Pivato Consulting, inc. All Rights Reserved.
		Minor modification © 2004 by Unity-Bars, Ltd.
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 00000000009C0000 002C000000020000 0003000000FFFFFF FFFFFFFFFFFCFFFF
0040: FFE9FFFFFF160000 0016000000F70100 0035010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
		Outline Window State: Maximized
		Outline Window Location and Size
.data VIEWINFO
0000: 6600040003001B00 0200000000000000 0000081EC2120500 1D00FFFF4D61696E
0020: 0029000100000000 0000000000E91E80 0A00008600FFFF49 6E7465726E616C20
0040: 46756E6374696F6E 7300200001000000 000000000000E91E 800A0000DF00FFFF
0060: 5661726961626C65 73001E0001000000 000000000000F51E 100D0000F400FFFF
0080: 436C617373657300
.enddata
.data VIEWSIZE
0000: 8800
.enddata
			Left:   -0.013"
			Top:    0.0"
			Width:  8.013"
			Height: 4.969"
		Options Box Location
.data VIEWINFO
0000: D418D007B80B1A00
.enddata
.data VIEWSIZE
0000: 0800
.enddata
			Visible? Yes
			Left:   4.15"
			Top:    1.885"
			Width:  3.8"
			Height: 2.073"
		Class Editor Location
			Visible? No
			Left:   0.575"
			Top:    0.094"
			Width:  5.063"
			Height: 2.719"
		Tool Palette Location
			Visible? No
			Left:   6.4"
			Top:    0.729"
		Fully Qualified External References? No
		Reject Multiple Window Instances? Yes
		Enable Runtime Checks Of External References? Yes
		Use Release 4.0 Scope Rules? No
	Libraries
	Global Declarations
		Window Defaults
			Tool Bar
				Display Style? Etched
				Font Name: System Default
				Font Size: System Default
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Form Window
				Display Style? Etched
				Font Name: System Default
				Font Size: System Default
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Dialog Box
				Display Style? Etched
				Font Name: System Default
				Font Size: System Default
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Top Level Table Window
				Font Name: System Default
				Font Size: System Default
				Font Enhancement: System Default
				Text Color: System Default
				Background Color: System Default
			Data Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Multiline Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Spin Field
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Background Text
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Pushbutton
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
			Radio Button
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Check Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Option Button
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
			Group Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Child Table Window
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			List Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Combo Box
				Font Name: Use Parent
				Font Size: Use Parent
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Line
				Line Color: Use Parent
			Frame
				Border Color: Use Parent
				Background Color: Use Parent
			Picture
				Border Color: Use Parent
				Background Color: Use Parent
		Formats
			Number: 0'%'
			Number: #0
			Number: ###000
			Number: ###000;'($'###000')'
			Date/Time: hh:mm:ss AMPM
			Date/Time: M/d/yy
			Date/Time: MM-dd-yy
			Date/Time: dd-MMM-yyyy
			Date/Time: MMM d, yyyy
			Date/Time: MMM d, yyyy hh:mm AMPM
			Date/Time: MMMM d, yyyy hh:mm AMPM
		External Functions
			! *** XSalTooltip
			Library name: XSal2_32.dll
				Function: XSalTooltipShow
					Description: HWND XSalTooltipShow( 
								HWND p_hwndParent, 
								LPSTR p_lpszText );
					Export Ordinal: 0
					Returns
						Window Handle: HWND
					Parameters
						Window Handle: HWND
						String: LPSTR
				Function: XSalTooltipSetText
					Description: BOOL XSalTooltipSetText( 
								LPSTR p_lpszTooltipText, 
								LPSTR p_lpszText );
					Export Ordinal: 0
					Returns
						Boolean: BOOL
					Parameters
						Number: LONG
						String: LPSTR
				Function: XSalTooltipSetFont
					Description: void XSalTooltipSetFont( 
								HFONT p_hFont );
					Export Ordinal: 0
					Returns
					Parameters
						Number: LONG
				Function: XSalTooltipSetDelay
					Description: void XSalTooltipSetDelay( 
								int p_iDelayOn, 
								int p_iDelayOff );
					Export Ordinal: 0
					Returns
					Parameters
						Number: INT
						Number: INT
				Function: XSalTooltipSetColors
					Description: void XSalTooltipSetColors( 
								COLORREF p_cTextColor, 
								COLORREF p_cBackColor );
					Export Ordinal: 0
					Returns
					Parameters
						Number: LONG
						Number: LONG
				Function: XSalTooltipSetDistance
					Description: void XSalTooltipSetDistance( 
								int p_iXOff, 
								int p_iYOff );
					Export Ordinal: 0
					Returns
					Parameters
						Number: INT
						Number: INT
				Function: XSalTooltipSetDefaults
					Description: void XSalTooltipSetDefaults( void );
					Export Ordinal: 0
					Returns
					Parameters
		Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
			System
				! //
						! // XSalTooltip Constants
						! //
				! *** Messages
				Number: SAM_TooltipSetText	= 0xC005
					! The child window where the mouse "rests" receives this message 
							  to show the tooltip text.
							
								wParam =	not used.
								lParam =	pointer to the buffer where the tooltip text
										should go.
				Number: SAM_TooltipClose	= 0xC006
					! The child window that owns the tooltip receives this message when
							  the tooltip is destroyed.
							
								wParam =	not used.
								lParam =	not used.
			User
		Resources
		Variables
		Internal Functions
			Function: XSalTooltipSetUserDefault
				Description: SetUp User defined values for ToolTips
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call XSalTooltipSetColors( COLOR_Black, COLOR_White )
					Call XSalTooltipSetDistance( 0, 15 )
					Call XSalTooltipSetDelay( 200, 4000 )
		Named Menus
		Class Definitions
		Default Classes
			MDI Window: cBaseMDI
			Form Window:
			Dialog Box:
			Table Window:
			Quest Window:
			Data Field:
			Spin Field:
			Multiline Field: cQuickMLField
			Pushbutton: cQuickCommander
			Radio Button:
			Option Button:
			Check Box:
			Child Table: cQuickTable
			Quest Child Window: cQuickDatabase
			List Box:
			Combo Box:
			Picture: cQuickPicture
			Vertical Scroll Bar:
			Horizontal Scroll Bar:
			Column:
			Background Text:
			Group Box:
			Line:
			Frame:
			Custom Control: cQuickGraph
		Application Actions
