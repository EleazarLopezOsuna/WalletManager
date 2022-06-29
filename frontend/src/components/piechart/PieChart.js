import React, {useEffect, useState} from 'react';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import { Pie } from 'react-chartjs-2';
import Cookies from "universal-cookie";
import {Row, Container, FormLabel} from "react-bootstrap";

let cookies = new Cookies();

ChartJS.register(ArcElement, Tooltip, Legend);

export const PieChart = () => {

    const data = {
        labels: ["Expenses", "Incomes"],
        datasets: [
            {
                label: "",
                data: [],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }
        ]
    }
    const [result, setResult] = useState({'Data': []})

    useEffect(() => {
        let walletExpenses = 0
        let walletIncomes = 0

        const fetchData = async () => {
            const response = await fetch(process.env.REACT_APP_API_ROUTE + 'wallet/user/summary/' + cookies.get('id'))
            const result = await response.json()
            result['result'].forEach(wallet => {
                if (wallet['type'] === 'Expense')
                    walletExpenses = wallet['total']
                else
                    walletIncomes = wallet['total']
            })
            setResult({'Data': [walletExpenses, walletIncomes]})
        }
        fetchData()
    }, [])

    data.datasets[0].data = result['Data'];

    return (
        <Container>
            <div className={"p-4"}>
                <Pie
                    data={data}
                    width={600}
                    height={400}
                    options={
                        {
                            maintainAspectRatio: false
                        }
                    }
                />
            </div>
            <div
                style={{
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center"
                }}
            >
                <Row className="justify-content-md-center">
                    <FormLabel>Expenses: {result['Data'][0]}  Incomes: {result['Data'][1]}</FormLabel>
                </Row>
            </div>
        </Container>
    )
}