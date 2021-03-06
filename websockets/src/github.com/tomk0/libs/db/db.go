package db

import (
	"database/sql"
	"fmt"

	misc "github.com/tomk0/libs/misc"
	stuc "github.com/tomk0/libs/structs"

	_ "github.com/go-sql-driver/mysql"
)

// GetAllMenu Is the function to Get the whole Menu
func GetAllMenu() []stuc.MenuItemOut {

	menu := make([]stuc.MenuItemOut, 1)

	db, err := sql.Open("mysql", "tom:pwd123@tcp(127.0.0.1:3306)/cafe_POS_v3")

	misc.CheckError(err)

	defer db.Close()

	results, err := db.Query("SELECT ITM.*, CAT.CAT_TYPE, CAT.CAT_NAME FROM ITEMS AS ITM JOIN ITEM_CATEGORY AS IC ON ITM.ITM_ID = IC.IC_ITM_ID JOIN CATEGORY AS CAT ON IC.IC_CAT_ID = CAT.CAT_ID WHERE ITM.ITM_AMOUNT > 0;")

	misc.CheckError(err)

	for results.Next() {

		var tmp stuc.MenuItemOut

		err = results.Scan(&tmp.ID, &tmp.Name, &tmp.Disc, &tmp.Price, &tmp.Amount, &tmp.Category, &tmp.Cat_Name)

		misc.CheckError(err)

		/*
			fmt.Println("\n----------------------------------------------------------")
			fmt.Println("ID: ", tmp.ID)
			fmt.Println("Name: ", tmp.Name)
			fmt.Println("Description: ", tmp.Disc)
			fmt.Println("Price: ", tmp.Price)
			fmt.Println("Amount: ", tmp.Amount)
			fmt.Println("Category: ", tmp.Category)
		*/

		if menu[0].ID == "" {

			menu[0] = tmp

		} else {

			menu = append(menu, tmp)

		}

	}

	fmt.Println("Server: Whole Menu Sent got from database")
	return menu
}

func GetAllOrders() []stuc.OrderOut {

	Orders := make([]stuc.OrderOut, 1)

	db, err := sql.Open("mysql", "tom:pwd123@tcp(127.0.0.1:3306)/cafe_POS_v3")

	misc.CheckError(err)

	defer db.Close()

	results, err := db.Query("SELECT ORD.ORD_ID, ORD.ORD_TIME, ORD.ORD_TOTAL, TBL.TBL_NAME  FROM ORDERS AS ORD JOIN TABLES AS TBL ON ORD.ORD_TBL_ID = TBL.TBL_ID;")

	misc.CheckError(err)

	for results.Next() {

		var tmp stuc.OrderOut

		err = results.Scan(&tmp.ID, &tmp.Time, &tmp.Total, &tmp.Tabel)

		misc.CheckError(err)

			fmt.Println("\n----------------------------------------------------------")
			fmt.Println("ID: ", tmp.ID)
			fmt.Println("Time: ", tmp.Time)
			fmt.Println("Total: ", tmp.Total)
			fmt.Println("Table: ", tmp.Tabel)

		if Orders[0].ID == "" {

			Orders[0] = tmp

		} else {

			Orders = append(Orders, tmp)

		}

	}

	for i, Order := range Orders{

		tmparry := make([]stuc.OrderItemOut, 1)


		results, err = db.Query("SELECT ITM.ITM_NAME, OI.OI_NOTES, OI.OI_AMOUNT, OI.OI_FIL_ID FROM ORDER_ITEMS AS OI JOIN ITEMS AS ITM ON OI.OI_ITM_ID = ITM.ITM_ID WHERE OI.OI_ORD_ID = '" + Order.ID + "';")

		misc.CheckError(err)

		for results.Next(){

			var tmpItm stuc.OrderItemOut

			err = results.Scan(&tmpItm.Name, &tmpItm.Notes, &tmpItm.Amount ,&tmpItm.Filling)

			fmt.Println("\n---------------------------------------------------------- ", Order.ID ," " , i)
			fmt.Println("Item: ", tmpItm.Name)
			fmt.Println("Notes: ", tmpItm.Notes)
			fmt.Println("Amount: ", tmpItm.Amount)

			tmpItm.Filling = getItemFilling(tmpItm.Filling)

			fmt.Println("Filling: ", tmpItm.Filling)

			if (tmparry[0].Name == ""){

				tmparry[0] = tmpItm

			}else{

				tmparry = append(tmparry, tmpItm)
			}

		}

		Orders[i].Items = tmparry

	}

	fmt.Println("Server: All Orders Sent got from database")
	return Orders
}


func GetAnOrder(OrderID string) stuc.OrderOut {

	var Orders stuc.OrderOut

	db, err := sql.Open("mysql", "tom:pwd123@tcp(127.0.0.1:3306)/cafe_POS_v3")

	misc.CheckError(err)

	defer db.Close()

	results, err := db.Query("SELECT ORD.ORD_ID, ORD.ORD_TIME, ORD.ORD_TOTAL, TBL.TBL_NAME  FROM ORDERS AS ORD JOIN TABLES AS TBL ON ORD.ORD_TBL_ID = TBL.TBL_ID WHERE ORD.ORD_ID = '" + OrderID + "';")

	misc.CheckError(err)

	for results.Next() {

		var tmp stuc.OrderOut

		err = results.Scan(&tmp.ID, &tmp.Time, &tmp.Total, &tmp.Tabel)

		misc.CheckError(err)
			/*
			fmt.Println("\n----------------------------------------------------------")
			fmt.Println("ID: ", tmp.ID)
			fmt.Println("Time: ", tmp.Time)
			fmt.Println("Total: ", tmp.Total)
			fmt.Println("Table: ", tmp.Tabel)
			*/
			Orders = tmp
	}

		tmparry := make([]stuc.OrderItemOut, 1)



		results, err = db.Query("SELECT ITM.ITM_NAME, OI.OI_NOTES, OI.OI_AMOUNT, OI.OI_FIL_ID FROM ORDER_ITEMS AS OI JOIN ITEMS AS ITM ON OI.OI_ITM_ID = ITM.ITM_ID WHERE OI.OI_ORD_ID = '" + OrderID + "';")

		misc.CheckError(err)

		i := 0

		for results.Next(){

			var tmpItm stuc.OrderItemOut

			err = results.Scan(&tmpItm.Name, &tmpItm.Notes, &tmpItm.Amount, &tmpItm.Filling)
			/*
			fmt.Println("\n---------------------------------------------------------- ", OrderID ," " , i)
			fmt.Println("ID-ITM: ", tmpItm.Name)
			fmt.Println("ID-FILL: ", tmpItm.Notes)
			fmt.Println("Amount: ", tmpItm.Amount)
			*/

			tmpItm.Filling = getItemFilling(tmpItm.Filling)


			if (tmparry[0].Name == ""){

				tmparry[0] = tmpItm

			}else{

				tmparry = append(tmparry, tmpItm)
			}

			i += i
		}

		Orders.Items = tmparry

	fmt.Println("Server: ", OrderID ," Orders Sent got from database")
	return Orders
}

func getItemFilling(FillingID string) string{

	var ret string

	db, err := sql.Open("mysql", "tom:pwd123@tcp(127.0.0.1:3306)/cafe_POS_v3")

	misc.CheckError(err)

	defer db.Close()

	if (FillingID != ""){

		results, err := db.Query("SELECT FILL_NAME FROM FILLINGS WHERE FILL_ID = '" + FillingID + "';")
		misc.CheckError(err)
	
		for results.Next(){

					err = results.Scan(&ret)
		}
	}else {

		ret = " "

	}

	return ret
}

func GetFilling(ItemID string) []stuc.FillingOut{

	FillingAry := make([]stuc.FillingOut, 1)

	db, err := sql.Open("mysql", "tom:pwd123@tcp(127.0.0.1:3306)/cafe_POS_v3")

	misc.CheckError(err)

	defer db.Close()

	results, err := db.Query("SELECT FIL.FILL_NAME, FIL.FILL_FILLING_DESC FROM FILLINGS AS FIL JOIN FILLINGS_ITEMS AS FI ON FIL.FILL_ID = FI.FI_FILL_ID WHERE FI.FI_ITM_ID = '"+ ItemID +"';")

	i := 0;

	for results.Next() {

		var tmp stuc.FillingOut

		err = results.Scan(&tmp.Name, &tmp.Disc)

		misc.CheckError(err)
			fmt.Println("\n----------------------------------------------------------")
			fmt.Println("Name: ", tmp.Name)
			fmt.Println("Disc: ", tmp.Disc)

			if (FillingAry[0].Name == ""){

				FillingAry[0] = tmp

			}else {

				FillingAry = append(FillingAry, tmp)
			}

		i += i

	}

	return FillingAry
}