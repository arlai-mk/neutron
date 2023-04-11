// Code generated by MockGen. DO NOT EDIT.
// Source: ./../../x/cron/types/expected_keepers.go

// Package mock_types is a generated GoMock package.
package mock_types

import (
	context "context"
	reflect "reflect"

	types "github.com/CosmWasm/wasmd/x/wasm/types"
	types0 "github.com/cosmos/cosmos-sdk/types"
	gomock "github.com/golang/mock/gomock"
)

// MockAccountKeeper is a mock of AccountKeeper interface.
type MockAccountKeeper struct {
	ctrl     *gomock.Controller
	recorder *MockAccountKeeperMockRecorder
}

// MockAccountKeeperMockRecorder is the mock recorder for MockAccountKeeper.
type MockAccountKeeperMockRecorder struct {
	mock *MockAccountKeeper
}

// NewMockAccountKeeper creates a new mock instance.
func NewMockAccountKeeper(ctrl *gomock.Controller) *MockAccountKeeper {
	mock := &MockAccountKeeper{ctrl: ctrl}
	mock.recorder = &MockAccountKeeperMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockAccountKeeper) EXPECT() *MockAccountKeeperMockRecorder {
	return m.recorder
}

// GetModuleAddress mocks base method.
func (m *MockAccountKeeper) GetModuleAddress(moduleName string) types0.AccAddress {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "GetModuleAddress", moduleName)
	ret0, _ := ret[0].(types0.AccAddress)
	return ret0
}

// GetModuleAddress indicates an expected call of GetModuleAddress.
func (mr *MockAccountKeeperMockRecorder) GetModuleAddress(moduleName interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "GetModuleAddress", reflect.TypeOf((*MockAccountKeeper)(nil).GetModuleAddress), moduleName)
}

// MockWasmMsgServer is a mock of WasmMsgServer interface.
type MockWasmMsgServer struct {
	ctrl     *gomock.Controller
	recorder *MockWasmMsgServerMockRecorder
}

// MockWasmMsgServerMockRecorder is the mock recorder for MockWasmMsgServer.
type MockWasmMsgServerMockRecorder struct {
	mock *MockWasmMsgServer
}

// NewMockWasmMsgServer creates a new mock instance.
func NewMockWasmMsgServer(ctrl *gomock.Controller) *MockWasmMsgServer {
	mock := &MockWasmMsgServer{ctrl: ctrl}
	mock.recorder = &MockWasmMsgServerMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockWasmMsgServer) EXPECT() *MockWasmMsgServerMockRecorder {
	return m.recorder
}

// ExecuteContract mocks base method.
func (m *MockWasmMsgServer) ExecuteContract(arg0 context.Context, arg1 *types.MsgExecuteContract) (*types.MsgExecuteContractResponse, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ExecuteContract", arg0, arg1)
	ret0, _ := ret[0].(*types.MsgExecuteContractResponse)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// ExecuteContract indicates an expected call of ExecuteContract.
func (mr *MockWasmMsgServerMockRecorder) ExecuteContract(arg0, arg1 interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ExecuteContract", reflect.TypeOf((*MockWasmMsgServer)(nil).ExecuteContract), arg0, arg1)
}