package main

import (
	"fmt"
	"sync"
)

func calculateEvenSum(id int, chunk []int, wg *sync.WaitGroup, resultChan chan<- int) {
	defer wg.Done()

	sum := 0
	for _, num := range chunk {
		if num%2 == 0 {
			sum += num
		}
	}
	fmt.Printf("Worker %d selesai menghitung total: %d\n", id, sum)
	resultChan <- sum
}

func main() {
	data := make([]int, 1000)
	for i := 0; i < 1000; i++ {
		data[i] = i + 1
	}

	numWorkers := 4
	totalData := len(data)
	chunkSize := totalData / numWorkers

	var wg sync.WaitGroup
	resultChan := make(chan int, numWorkers)

	for i := 0; i < numWorkers; i++ {
		start := i * chunkSize
		end := start + chunkSize

		if i == numWorkers-1 {
			end = totalData
		}

		chunk := data[start:end]

		wg.Add(1)
		go calculateEvenSum(i+1, chunk, &wg, resultChan)
	}

	go func() {
		wg.Wait()
		close(resultChan)
	}()

	totalEvenSum := 0
	for sum := range resultChan {
		totalEvenSum += sum
	}

	fmt.Println("--------------------------------------------------")
	fmt.Printf("Total jumlah bilangan genap dari semua worker: %d\n", totalEvenSum)
}
