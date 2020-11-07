xmlport 84002 "Consulta SILICIE"
{
    // version SIL0001

    Direction = Export;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    Namespaces = ent = 'https://www3.agenciatributaria.gob.es/static_files/common/internet/dep/aduanas/es/aeat/adsi/lico/ws/v1/consultas/alc/IESA2V1Ent.xsd', cab = 'https://www3.agenciatributaria.gob.es/static_files/common/internet/dep/aduanas/es/aeat/adsi/lico/ws/v1/comun/Cabeceras.xsd', lin = 'https://www3.agenciatributaria.gob.es/static_files/common/internet/dep/aduanas/es/aeat/adsi/lico/ws/v1/comun/Tipos.xsd', tip = 'https://www3.agenciatributaria.gob.es/static_files/common/internet/dep/aduanas/es/aeat/adsi/lico/ws/v1/comun/Tipos.xsd', soapenv = 'http://schemas.xmlsoap.org/soap/envelope/', "SOAP-ENC" = 'http://schemas.xmlsoap.org/soap/encoding/';

    schema
    {
        textelement(Envelope)
        {
            NamespacePrefix = 'soapenv';
            textelement(Body)
            {
                NamespacePrefix = 'soapenv';
                tableelement("Envío SILICIE"; "Request Setup")
                {
                    NamespacePrefix = 'ent';
                    XmlName = 'IESA2V1Ent';
                    textattribute(Id)
                    {
                    }
                    textattribute(Test)
                    {
                    }
                    textelement(Cabecera)
                    {
                        NamespacePrefix = 'ent';
                        textelement(IdentificadorMensaje)
                        {
                            NamespacePrefix = 'cab';
                        }
                        textelement(DatosEstablecimiento)
                        {
                            NamespacePrefix = 'cab';
                            textelement(NIFEs)
                            {
                                NamespacePrefix = 'cab';
                            }
                            textelement(CAEEs)
                            {
                                NamespacePrefix = 'cab';
                            }
                        }
                    }
                    textelement(Cuerpo)
                    {
                        NamespacePrefix = 'ent';
                        textelement(ClavePaginacion)
                        {
                            NamespacePrefix = 'tip';
                            textelement(Pagina)
                            {
                                NamespacePrefix = 'tip';
                            }
                        }
                        textelement(Filtro)
                        {
                            NamespacePrefix = 'tip';
                            textelement(DatosIdentificativosAsiento)
                            {
                                NamespacePrefix = 'tip';
                                textelement(NumReferenciaInterno)
                                {
                                    NamespacePrefix = 'tip';
                                }
                            }
                            textelement(FiltroFecha)
                            {
                                NamespacePrefix = 'tip';
                                textelement(FechaRegistroContable)
                                {
                                    NamespacePrefix = 'tip';
                                    textelement(FecRegDesde)
                                    {
                                        NamespacePrefix = 'tip';
                                    }
                                    textelement(FecRegHasta)
                                    {
                                        NamespacePrefix = 'tip';
                                    }
                                }
                            }
                        }
                    }

                    trigger OnAfterGetRecord()
                    var
                    begin
                        FecRegDesde := Format("Envío SILICIE"."Date From", 0, 9);
                        FecRegHasta := Format("Envío SILICIE"."Date To", 0, 9);
                        //NumReferenciaInterno := 'AQUI';
                        NIFEs := "Envío SILICIE"."Vat Number Declaration";
                        CAEEs := "Envío SILICIE".CAE;
                        Pagina := '1';
                        Test := 'N';
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    procedure SetIdMessage(NewIdMessa: code[20])
    var
    begin
        Id := NewIdMessa;
        IdentificadorMensaje := NewIdMessa;
    end;

    var
        PlusMonth: Label '<+1M>';
        MinusMonth: Label '<-1M>';
}

