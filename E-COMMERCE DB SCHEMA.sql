CREATE TABLE Customers (
	CustomerID serial,
    Name varchar(20) NULL,
	Email varchar(64) NULL,
	Address varchar(64) NULL,
	CONSTRAINT Customer_PK PRIMARY KEY(CustomerID)
);

CREATE TABLE Orders (
	OrderID serial,
    CustomerID int4 NOT NULL,
	Order_Date date NULL,
	Total_Amount int4 NULL,
	CONSTRAINT Order_PK PRIMARY KEY (OrderID),
	CONSTRAINT Customer_FK FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)
);

CREATE TABLE Order_Items (
	OrderItemID serial,
	OrderID int4 NULL,
	ProductID int4 NULL,
	Quantity int4 NULL,
	Price float4 NULL,
	CONSTRAINT Order_Items_PK PRIMARY KEY (OrderItemID),
	CONSTRAINT Order_FK FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
	CONSTRAINT Product_FK FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);


CREATE TABLE Products (
	ProductID serial,
	"Name" VARCHAR(20) NULL,
	Description VARCHAR(2000) NULL,
	Price float4 NULL,
	Quantity int4 DEFAULT 0,
	CONSTRAINT Products_PK PRIMARY KEY (ProductID)
);

CREATE TABLE Categories (
	CategoryID serial,
	"Name" varchar(64) NULL,
	CONSTRAINT Categories_PK PRIMARY KEY (CategoryID)
);

CREATE TABLE Product_Categories (
	ProductID int4 NULL,
	CategoryID int4 NULL,
	CONSTRAINT Product_Categories_PK PRIMARY KEY (ProductID, CategoryID),
	CONSTRAINT Category_FK FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE,
	CONSTRAINT Product_FK FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE

);

CREATE TABLE Reviews (
	ReviewID serial,
	ProductID int4 NULL,
	CustomerID int4 NULL,
	Rating numeric(2, 1) NULL,
	Product_Comment varchar(2000) NULL,
	CONSTRAINT Check_Rating CHECK (((Rating >= (0)::numeric) AND (Rating <= (5)::numeric))),
	CONSTRAINT Reviews_PK PRIMARY KEY (ReviewID),
	CONSTRAINT Customer_FK FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
	CONSTRAINT Product_FK FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Suppliers (
	SupplierID serial,
	Supplier_Name VARCHAR(64) NULL,
	Address VARCHAR(64) NULL,
	Phone_Number VARCHAR(15) NULL,
	CONSTRAINT Suppliers_PK PRIMARY KEY (SupplierID)
)

CREATE TABLE Product_Suppliers (
	ProductID int4 NOT NULL,
	SupplierID int4 NOT NULL,
	CONSTRAINT Product_Suppliers_PK PRIMARY KEY (ProductID, SupplierID),
	CONSTRAINT Product_FK FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
	CONSTRAINT Supplier_FK FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE
);

