import React, {useEffect, useState} from 'react';
import {NavBar} from "../components/nabvar/NavBar";
import {Container, Row, Col, FormLabel} from "react-bootstrap"
import Cookies from "universal-cookie";
import Swal from "sweetalert2";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend,
} from 'chart.js';
import {Bar, Pie} from 'react-chartjs-2';

const cookies = new Cookies();

ChartJS.register(
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend
);

export const Report = () => {

    let [categoryLabels, setCategoryLabels] = useState([]);
    let [typeLabels, setTypeLabels] = useState([]);
    let [dateLabels, setDateLabels] = useState([]);
    let [datasetCategory, setDatasetCategory] = useState([]);
    let [datasetType, setDatasetType] = useState([]);
    let [datasetDate, setDatasetDate] = useState([]);

    useEffect(() => {
        if(!cookies.get('id')){
            Swal.fire("Error", "You must be logged in", "error").then( () => {
                window.location.href="./";
            })
        }

        const fetchData = async () => {
            const response = await fetch(process.env.REACT_APP_API_ROUTE + 'transaction/report/1')
            const result = await response.json()
            result['result']['categories'].forEach(element => {
                categoryLabels.push(element['name'])
                datasetCategory.push(element['amount'])
            })

            result['result']['types'].forEach(element => {
                typeLabels.push(element['name'])
                datasetType.push(element['amount'])
            })

            result['result']['dates'].forEach(element => {
                dateLabels.push(element['name'])
                datasetDate.push(element['amount'])
            })
        }

        fetchData()
    });


    let categoryData = {
        labels: categoryLabels,
        datasets: [
            {
                label: 'Categories',
                data: datasetCategory,
                backgroundColor: 'rgba(255, 99, 132, 0.5)',
            },
        ],
    }

    console.log(categoryData)

    let typeData = {
        labels: typeLabels,
        datasets: [
            {
                label: 'Types',
                data: datasetType,
                backgroundColor: 'rgba(0, 99, 132, 0.5)',
            },
        ],
    }

    let dateData = {
        labels: dateLabels,
        datasets: [
            {
                label: 'Dates',
                data: datasetDate,
                backgroundColor: 'rgba(255, 99, 0, 0.5)',
            },
        ],
    }


    return (
        <Container fluid>
            <NavBar/>
            <div className={"p-4"}>
                <Bar
                    data={categoryData}
                    width={600}
                    height={400}
                    options={
                        {
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Category summary',
                                },
                            },
                        }
                    }
                />
            </div>
            <div className={"p-4"}>
                <Bar
                    data={typeData}
                    width={600}
                    height={400}
                    options={
                        {
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Types summary',
                                },
                            },
                        }
                    }
                />
            </div>
            <div className={"p-4"}>
                <Bar
                    data={dateData}
                    width={600}
                    height={400}
                    options={
                        {
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: 'Dates summary',
                                },
                            },
                        }
                    }
                />
            </div>
        </Container>
    )
}