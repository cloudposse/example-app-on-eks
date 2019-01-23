package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	c := os.Getenv("COLOR")
	if len(c) == 0 {
		c = "cyan"
	}
	count := 0

	// Healthcheck endpoint
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "OK")
		fmt.Printf("GET %s\n", r.URL.Path)
	})

	// Take one for the team
	boom, _ := ioutil.ReadFile("public/boom.html")
	http.HandleFunc("/boom", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, string(boom))
		fmt.Printf("Goodbye\n")
		//die()
	})

	// Dashboard
	dashboard, _ := ioutil.ReadFile("public/dashboard.html")
	http.HandleFunc("/dashboard", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, string(dashboard))
		fmt.Printf("GET %s\n", r.URL.Path)
	})

	// Default
	index, _ := ioutil.ReadFile("public/index.html")
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		count += 1
		fmt.Fprintf(w, string(index), c, count)
		fmt.Printf("GET %s\n", r.URL.Path)
	})

	http.ListenAndServe(":8080", nil)
}

func die() {
	os.Exit(3)
}
