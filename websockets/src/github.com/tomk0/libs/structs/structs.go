package structs

type FillingOut struct {

	Name string `json:"Name"`
	Disc string `json:"Disc"`

}

type MenuItemOut struct {
	ID       string  `json:"Id"`
	Name     string  `json:"Name"`
	Disc     string  `json:"Disc"`
	Price    float64 `json:"Price"`
	Amount   int     `json:"Amount"`
	Category string  `json:"Category"`
	Cat_Name  string  `json:"Cat_Name"`
}

type MenuOut struct {
	ItemsAry []MenuItemOut `json:"Items"`
}

type OrderOut struct {
	ID    string         `json:"ID"`
	Time  string         `json:"Time"`
	Tabel string         `json:"Tabel"`
	Total float64        `json:"Total"`
	Items []OrderItemOut `json:"Items"`
}

type OrderItemOut struct {
	Name string `json:"ItemID"`
	Filling string `json:"Filling"`
	Notes string `json:"Notes"`
	Amount int    `json:"Amount"`
}

type DataOut struct {
	Used    bool       `json:"Used"`
	Menu    MenuOut    `json:"Menu"`
	Orders  []OrderOut `json:"All_Order_Out"`
	Order   OrderOut   `json:"Order_Out"`
	Filling []FillingOut `json:"Filling"` 
}

type CmdOut struct {
	Cmd  string  `json:"Cmd"`
	Data DataOut `json:"Data"`
}

type OrderIn struct {
	ITM_ID  string  `json:"ITM_ID"`
	FILL_ID string  `json:"FILL_ID"`
	Amount  int     `json:"Amount"`
	Price   float64 `json:"Price"`
	Notes   string  `json:"Notes"`
}

type DataIn struct {
	Order []OrderIn `json:"Order"`
	Opt string `json:"Opt"`
}

type CmdIn struct {
	Cmd  string `json:"Cmd"`
	Data DataIn `json:"Data"`
}
