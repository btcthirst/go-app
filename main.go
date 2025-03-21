package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", healthCheckHandler)

	e.GET("/ping", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "OK"})
	})

	httpPort := os.Getenv("PORT")
	fmt.Println("from os.getenv: ", httpPort)
	if httpPort == "" {
		httpPort = "4000"
		fmt.Println("from =: ", httpPort)
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}

func healthCheckHandler(c echo.Context) error {
	return c.JSON(http.StatusOK, struct{ Status string }{Status: "OK"})
}
